require 'arkency/command_bus'
require 'securerandom'

class TasksService
  def initialize
    @repository = AggregateRoot::Repository.new(Rails.application.config.event_store)
  end

  def call(cmd)
    submit(cmd)
  end
  private

  def submit(cmd)
    aggregate_id = SecureRandom.uuid
    task = Tasks::Task.new(aggregate_id: aggregate_id ,title: cmd.title)
    task.submit
    task.add_tag(tag_title: 'new Ttag')
    @repository.store(task, aggregate_id)
  end
end
