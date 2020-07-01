# To-Do app Domain-Driven-Design approach.

# Gems

1. rails_event_store to persist events and manage pub/sub.
2. classy_hash to validate domain events data.
3. Scenic to build SQL views in PostgreSQL.

Main aggregate_root is task.rb under app/tasks/lib

tasks_service under app/services.


usage: 

`rake db:create && rake db:migrate`
then `bundle install`

then `rails s`
