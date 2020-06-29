Rails.application.config.event_store.tap do |es|

  es.subscribe(->(event){
    TaskRecord::TaskSubmittedHandler.new.call(event)
  }, to: [Tasks::TaskSubmitted] )

  es.subscribe(->(event){
    TaskRecord::TagAddedHandler.new.call(event)
  }, to: [Tasks::TagAdded] )

end
