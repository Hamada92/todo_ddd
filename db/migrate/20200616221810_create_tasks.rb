class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :title, null: false, default: ''
      t.timestamps
    end
  end
end
