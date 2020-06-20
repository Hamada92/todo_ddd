# WorkDay To-Do app

This app requires ruby `2.6.5`, as specified in `.ruby-verson` file. Rails `5.2.4.1`

The app uses PostgreSQL as the Database.

after cloning the repo, run `rake db:create && rake db:migrate && rake db:seed`  then `bundle install`.
To run the tests run `bundle exec rspec`,

`rails s` to start the server.

# Gems

I've used some gems to help with development:

1. Jbuilder for JSON responses.
2. Scenic to build SQL views in PostgreSQL.
3. FactoryBot to create test objects.
4. Rubocop for linting.
5. Simplecov for test coverage.

# Models and API

I created 3 tables and 1 View:
Task
Tag
TaskTag
TaskWithAssociatedTag (SQL view)

Task and Tag has a many-to-many relationship.

In the migrations, I chose to use pure SQL to build my tables, it gives me more control over foreign keys, triggers (cascades), indices, and contraints.

Created a SQL view under `db/views` that gets tasks along with their associated tags using the hstore datatype in postgres (tag_id: tag_name), I did this because getting a task along with its tags is a frequent operation which could lead to N+1 problems, using this View will issue one query only.

Under the `services` folder, I created a service object that encapsulates the logic for updating/tagging a task, and tested separately in Rspec. This could've also been part of the task model, or even a Taggable concern that's included in the model, but its my opinion that as models tend to grow too big, services can help with keeping the models at moderate size.

I had to make a choice whether to make the bridge table (task_tags) polymprphic, so that in the future it could be used to tag other models (e.g. Article), but polymorphic associations ignore referential integrity in the database, which is something that shouldn't be sacrificed, so I decided against it.

I had to make 2 small changes to the postman-test file: 
1. Remove the `[0]` from line 323 and 325
2. Expect the tag id to be any number greater than 0, instead of specifically expecting ids 2 and 3 (which changes from database to another)

Please re-import the postman-test file into Postman again using the version in this repo, since it has minor changes, then run the collection, should all be green.


# Pagination

I paginated the tasks index usign Kaminari, the json payload will include these links:
`first` links to the first page
`last` links to the last page
`next` links to the next page
`prev` links to the previous page

this format is compliant with JSON API requirement.

To get a specific page of record, pass the query param `page`, e.g. `localhost:3000/api/v1/tasks?page=2`


# Notes

1. in postman-test.json, the request to create a tag (POST localhost:3000/v1/api/tags), the test will pass the first time, but on consequent tries, it will return a 422 code since the api doesn't allow duplicate tag title's.


