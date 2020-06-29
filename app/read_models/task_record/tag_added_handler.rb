module TaskRecord
  class TagAddedHandler
    def call(ev)
      tag = TagRecord::Tag.find_or_create_by!(
        title: ev.data.fetch(:title),
        code: ev.data.fetch(:title).downcase.gsub(" ", "_")
      )

      task = TaskRecord::Task.find_by!(aggregate_id: ev.data.fetch(:aggregate_id))
      TaskTagRecord::TaskTag.find_or_create_by!(tag_id: tag.id, task_id: task.id)
    end
  end
end
