require 'ruby_event_store'

module Tasks

  class TaskSubmitted < RailsEventStore::Event
    SCHEMA = {
      aggregate_id: String,
      title: String,
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end

  class TagAdded < RailsEventStore::Event
    SCHEMA = {
      aggregate_id: String,
      title: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
