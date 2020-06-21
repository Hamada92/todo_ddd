# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_18_010911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "tags", id: :serial, force: :cascade do |t|
    t.text "title", default: "", null: false
    t.text "code", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "code_tags", unique: true
    t.index ["title"], name: "title_tags", unique: true
  end

  create_table "task_tags", id: :serial, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "task_id", null: false
    t.index ["tag_id"], name: "tag_id_task_tags"
    t.index ["task_id", "tag_id"], name: "tag_id_task_id_task_tags", unique: true
  end

  create_table "tasks", id: :serial, force: :cascade do |t|
    t.text "title", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "task_tags", "tags", name: "task_tags_tag_id_fkey", on_delete: :cascade
  add_foreign_key "task_tags", "tasks", name: "task_tags_task_id_fkey", on_delete: :cascade

  create_view "task_with_associated_tags", sql_definition: <<-SQL
      SELECT tasks.id,
      tasks.title,
      tasks.created_at,
      tasks.updated_at,
      ( SELECT hstore(array_agg((tags.id)::text), array_agg(tags.title)) AS hstore
             FROM (tags
               JOIN task_tags ON ((tags.id = task_tags.tag_id)))
            WHERE (task_tags.task_id = tasks.id)) AS tags
     FROM tasks;
  SQL
end
