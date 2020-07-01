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
      tag_title: String,
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end

  class TaskUpdated < RailsEventStore::Event
    SCHEMA = {
      aggregate_id: String,
      title: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end

  class TaskDeleted < RailsEventStore::Event
    SCHEMA = {
      aggregate_id: String,
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
