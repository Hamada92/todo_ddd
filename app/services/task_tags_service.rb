# frozen_string_literal: true

class TaskTagsService
  attr_reader :task_id, :task_params, :full_tag_replacement, :errors

  def initialize(task_id, task_params, full_tag_replacement: false)
    @task_id = task_id
    @task_params = task_params
    @full_tag_replacement = full_tag_replacement
  end

  def call
    ActiveRecord::Base.transaction do
      task.tags.delete_all if full_tag_replacement
      task.update!(task_params_without_tags)
      create_tags
    end
  rescue ActiveRecord::RecordInvalid => e
    @errors = e.record.errors
  end

  private

  def task
    Task.find(task_id)
  end

  def tags
    Array.wrap(task_params[:tags]).filter(&:present?)
  end

  def task_params_without_tags
    task_params.except(:tags)
  end

  def create_tags
    tags.each do |tag_title|
      tag = Tag.where(title: tag_title).first_or_create!
      task.task_tags.where(tag_id: tag.id).first_or_create! # Prevent duplicate tagging
    end
  end
end
