class CreateTags < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      create sequence tags_id_seq;
      create table tags (
        id integer NOT NULL default nextval('tags_id_seq'),
        title text NOT NULL default '',
        code text NOT NULL default '',
        created_at timestamp,
        updated_at timestamp,
        primary key(id)
      );

      CREATE UNIQUE INDEX title_tags on tags(code);
      CREATE UNIQUE INDEX code_tags on tags(code);
    SQL
  end

  def down
    execute <<-SQL
      drop table tags;
      drop sequence IF EXISTS tags_id_seq;
    SQL
  end
end
