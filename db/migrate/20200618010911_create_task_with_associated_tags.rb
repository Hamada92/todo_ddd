class CreateTaskWithAssociatedTags < ActiveRecord::Migration[5.2]
  def change
    create_view :task_with_associated_tags
  end
end
