class CreateTaskWithAssociatedTags < ActiveRecord::Migration[5.2]
  def change
    execute "CREATE EXTENSION hstore;"
    create_view :task_with_associated_tags
  end
end
