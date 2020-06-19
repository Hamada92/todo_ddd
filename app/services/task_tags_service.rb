class TaskTagsService
  attr_reader :task_id, :tags, :full_replacement, :errors

  def initialize(task_id, tags=[], full_replacement: false)
    @task_id = task_id
    @tags = Array.wrap(tags).filter { |tag| tag.present? } # Remove blank values
    @full_replacement = full_replacement
  end

  def call
    return unless tags.present?

    begin
      ActiveRecord::Base.transaction do
        task.tags.destroy_all if full_replacement
        tags.each do |tag_title|
          tag = Tag.where(title: tag_title).first_or_create!
          task.task_tags.where(tag_id: tag.id).first_or_create!
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      @errors = e.record.errors
    end

    return errors if errors.present?
  end

  private

  def task
    Task.find(task_id)
  end
end
