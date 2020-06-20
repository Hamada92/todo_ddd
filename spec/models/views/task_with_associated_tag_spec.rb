require 'rails_helper'

describe Views::TaskWithAssociatedTag do
  let(:task_tag) { create(:task_tag) }
  let(:tag) { task_tag.tag }
  let(:task) { task_tag.task }

  it 'returns the tasks with their tags hash' do
    task_view = described_class.find(task.id)
    expect(task_view.tags).to eq({"#{tag.id}"=>"#{tag.title}"})
  end
end
