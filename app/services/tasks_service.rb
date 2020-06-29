require 'arkency/command_bus'
require 'securerandom'

class TasksService
  def initialize
    @repository = AggregateRoot::Repository.new(Rails.application.config.event_store)
  end

  def call(cmd)
    submit(cmd)
  end

  def call2(cmd)
    edit(cmd)
  end
  private

  def submit(cmd)
    aggregate_id = SecureRandom.uuid
    stream = "Task#{aggregate_id}"
    task = Tasks::Task.new(aggregate_id: aggregate_id ,title: cmd.title)
    task.submit
    task.add_tag(tag_title: 'new Ttag')
    @repository.store(task, stream)
  end

  def edit(cmd)
    stream = "Task#{cmd.aggregate_id}"
    @repository.with_aggregate(
      Tasks::Task.new(aggregate_id: cmd.aggregate_id, title: cmd.title),
      stream) do |task|
      task.edit
    end
  end
end
