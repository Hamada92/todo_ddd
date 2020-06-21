require 'rails_helper'

describe Updaters::Task do
  let(:task) { create(:task) }
  let(:task_params) do
    {
      attributes: {
        title: 'New Title',
        tags: ["Home", "Fun"]
      }
    }
  end

  it 'updates the task' do
    described_class.new(task.id, task_params).call
    expect(task.reload.title).to eq("New Title")
  end

  it 'creates tags without duplicates' do
    described_class.new(task.id, task_params).call
    expect(task.tags.pluck(:title)).to eq(["Home", "Fun"])
  end

  context 'with full_tag_replacement' do
    before(:each) do
      tag = create(:tag)
      task.task_tags.create(tag_id: tag.id)
    end

    it 'destroy existing tags and replaces them with the new ones' do
      expect { described_class.new(task.id, task_params, full_tag_replacement: true).call }.
        to change { task.tags.pluck(:title) }.from(["Test Tag"]).to(["Home", "Fun"])
    end
  end
end
