class TaskTagsService
  attr_reader :task_id, :tags, :full_replacement

  def initialize(task_id, tags=[], full_replacement: false)
    @task_id = task_id
    @tags = tags.filter { |tag| tag.present? } # Remove blank values
    @full_replacement = full_replacement
  end

  def call
    return unless tags.present?

    if full_replacement
      task.tags.destroy_all
    end

    tags.each do |tag_title|
      tag = Tag.where(title: tag_title).first_or_create!
      task.task_tags.where(tag_id: tag.id).first_or_create!
    end
  end

  private

  def task
    Task.find(task_id)
  end
end
