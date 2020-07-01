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

ActiveRecord::Schema.define(version: 2020_06_28_123456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "event_store_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "event_type", null: false
    t.binary "metadata"
    t.binary "data", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
  end

  create_table "event_store_events_in_streams", id: :serial, force: :cascade do |t|
    t.string "stream", null: false
    t.integer "position"
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.text "title", default: "", null: false
    t.text "code", default: "", null: false
    t.uuid "aggregate_id"
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
    t.uuid "aggregate_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["aggregate_id"], name: "tasks_aggregate_id", unique: true
  end

  add_foreign_key "task_tags", "tags", name: "task_tags_tag_id_fkey", on_delete: :cascade
  add_foreign_key "task_tags", "tasks", name: "task_tags_task_id_fkey", on_delete: :cascade

  create_view "task_with_associated_tags", sql_definition: <<-SQL
      SELECT tasks.id,
      tasks.title,
      tasks.aggregate_id,
      tasks.deleted_at,
      tasks.created_at,
      tasks.updated_at,
      ( SELECT hstore(array_agg((tags.id)::text), array_agg(tags.title)) AS hstore
             FROM (tags
               JOIN task_tags ON ((tags.id = task_tags.tag_id)))
            WHERE (task_tags.task_id = tasks.id)) AS tags
     FROM tasks;
  SQL
end
