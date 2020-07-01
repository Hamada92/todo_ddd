class CreateTasks < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      create sequence tasks_id_seq;
      create table tasks (
        id integer NOT NULL default nextval('tasks_id_seq'),
        title text NOT NULL default '',
        aggregate_id uuid,
        deleted_at timestamp,
        created_at timestamp,
        updated_at timestamp,
        primary key(id)
      );
      CREATE UNIQUE INDEX tasks_aggregate_id on tasks(aggregate_id);
    SQL
  end

  def down
    execute <<-SQL
      drop table tasks;
      drop sequence IF EXISTS tasks_id_seq;
    SQL
  end
end
