require 'rails_helper'

describe TasksService do
  it 'successful task flow' do
    service = TasksService.new
    command = Tasks::SubmitTaskCommand.new(aggregate_id:  SecureRandom.uuid,
                                          title: 'Test Task')
    expect { service.call(command) }.to change { TaskRecord::Task.count }.by(1)
  end
end
