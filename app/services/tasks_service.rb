require 'arkency/command_bus'

class TasksService
  def initialize
    @repository = AggregateRoot::Repository.new(Rails.application.config.event_store)
    @command_bus    = Arkency::CommandBus.new
    { Tasks::SubmitTaskCommand      => method(:submit),
      Tasks::UpdateTaskCommand  => method(:edit),
      Tasks::DeleteTaskCommand  => method(:mark_deleted)
    }.map{|klass, handler| @command_bus.register(klass, handler)}
  end

  def call(*commands)
    commands.each do |cmd|
      @command_bus.call(cmd)
    end
  end
  private

  def submit(cmd)
    cmd.validate!
    stream = "Task#{cmd.aggregate_id}"
    task = Tasks::Task.new(aggregate_id: cmd.aggregate_id)

    task.submit(title: cmd.title)
    @repository.store(task, stream)
  end

  def edit(cmd)
    cmd.validate!
    stream = "Task#{cmd.aggregate_id}"
    @repository.with_aggregate(
      Tasks::Task.new(aggregate_id: cmd.aggregate_id),
      stream) do |task|
      task.edit(title: cmd.title)

      cmd.tags&.select(&:present?).each do |tag|
        task.add_tag(tag_title: tag)
      end
    end
  end

  def mark_deleted(cmd)
    cmd.validate!
    stream = "Task#{cmd.aggregate_id}"
    @repository.with_aggregate(
      Tasks::Task.new(aggregate_id: cmd.aggregate_id),
      stream) do |task|
      task.delete
    end
  end
end
