require 'rails_helper'

describe Views::TaskWithAssociatedTag do
  let(:task) { create(:task) }
  let(:tag) { create(:tag) }
  let!(:task_tag) { create(:task_tag, tag_id: tag.id, task_id: task.id) }

  it 'returns the tasks with their tags hash' do
    task_view = described_class.find(task.id)
    expect(task_view.tags).to eq({"#{tag.id}"=>"#{tag.title}"})
  end
end
