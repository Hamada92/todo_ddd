require 'aggregate_root'

module Tasks
  class Task
    include AggregateRoot
    Invalid    = Class.new(StandardError)

    def initialize(aggregate_id:)
      @aggregate_id = aggregate_id
    end

    def submit(title:)
      raise Invalid if title.blank?

      apply(TaskSubmitted.strict(data:
        {
          aggregate_id: aggregate_id,
          title: title,
        }))
    end

    def edit(title:)
      raise Invalid if title.blank?

      apply(TaskUpdated.strict(data:
      {
        aggregate_id: aggregate_id,
        title: title,
      }))
    end

    def add_tag(tag_title:)
      apply(TagAdded.strict(data:
      {
        aggregate_id: aggregate_id,
        tag_title: tag_title,
      }))
    end

    def delete
      apply(TaskDeleted.strict(data:
      {
        aggregate_id: aggregate_id
      }))
    end

    on TaskSubmitted do |event|
      @aggregate_id = event.data.fetch(:aggregate_id)
      @title = event.data.fetch(:title)
    end

    on TagAdded do |event|
    end

    on TaskUpdated do |event|
      @title = event.data.fetch(:title)
    end

    on TaskDeleted do |event|
    end

    private
    attr_reader :aggregate_id
  end
end
