require 'rails_helper'

describe Updaters::Factory do
  let(:task) { create(:task) }
  let(:task_params) do
    {
      title: 'New Title',
      tags: ["Home", "Fun"]
    }
  end

  it 'builds the correct instance' do
    expect(described_class.build(task, task_params).class).to eq(Updaters::Task)
  end
end
