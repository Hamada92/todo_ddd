class CreateTaskTags < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      create sequence task_tags_id_seq;
      create table task_tags (
        id integer NOT NULL default nextval('task_tags_id_seq'),
        tag_id integer NOT NULL references tags(id) ON DELETE CASCADE,
        task_id integer NOT NULL references tasks(id) ON DELETE CASCADE,
        primary key(id)
      );
      create index tag_id_task_tags on task_tags(tag_id);
      create unique index tag_id_task_id_task_tags on task_tags(task_id, tag_id);

    SQL
  end

  def down
    execute <<-SQL
      drop table task_tags;
      drop sequence IF EXISTS task_tags_id_seq;
    SQL
  end
end
