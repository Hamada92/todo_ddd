SELECT tasks.*,
  (select hstore(array_agg(tags.id::text), array_agg(tags.title)) FROM tags INNER JOIN task_tags ON tags.id = task_tags.tag_id
  	WHERE task_tags.task_id = tasks.id) as tags
FROM "tasks"