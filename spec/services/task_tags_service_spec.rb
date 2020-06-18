require 'rails_helper'

describe TaskTagsService do
  let(:task) { create(:task) }

  it 'creates tags' do
    described_class.new(task.id, ["Tag", "Tag2", ""]).call
    expect(task.tags.pluck(:title)).to eq(["Tag", "Tag2"])
  end

  context 'with full_replacement' do
    before(:each) do
      tag = create(:tag)
      task.task_tags.create(tag_id: tag.id)
    end

    it 'destroy existing tags and replaces them with the new ones' do
      expect { described_class.new(task.id, ["New"], full_replacement: true).call }.
        to change { task.tags.pluck(:title) }.from(["Test Tag"]).to(["New"])
    end
  end
end
