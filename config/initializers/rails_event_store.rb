Rails.application.config.event_store.tap do |es|

  es.subscribe(->(event){
    TaskRecord::TaskSubmittedHandler.new.call(event)
  }, to: [Tasks::TaskSubmitted] )

  es.subscribe(->(event){
    TaskRecord::TagAddedHandler.new.call(event)
  }, to: [Tasks::TagAdded] )

  es.subscribe(->(event){
    TaskRecord::TaskUpdatedHandler.new.call(event)
  }, to: [Tasks::TaskUpdated] )

  es.subscribe(->(event){
    TaskRecord::TaskDeletedHandler.new.call(event)
  }, to: [Tasks::TaskDeleted] )

end
