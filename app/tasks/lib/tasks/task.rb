require 'aggregate_root'

module Tasks
  class Task
    include AggregateRoot

    def initialize(aggregate_id:, title:)
      @aggregate_id = aggregate_id
      @title = title
    end

    def submit
      apply(TaskSubmitted.strict(data:
        {
          aggregate_id: aggregate_id,
          title: title,
        }))
    end

    def edit
      apply(TaskTitleUpdated.strict(data:
      {
        aggregate_id: aggregate_id,
        title: title,
      }))
    end

    def add_tag(tag_title:)
      apply(TagAdded.strict(data:
      {
        aggregate_id: aggregate_id,
        title: tag_title,
      }))
    end

    on TaskSubmitted do |event|
      @aggregate_id = event.data.fetch(:aggregate_id)
      @title = event.data.fetch(:title)
    end

    on TagAdded do |event|
    end

    on TaskTitleUpdated do |event|
      @title = event.data.fetch(:title)
    end

    private
    attr_reader :title, :aggregate_id
  end
end
