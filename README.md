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

Under the `services` folder, I implemented the factory method pattern, which builds an instance of the updater class (in this case a Task updater). If in the future we need to tag an Article or a Question, it's easy to extend.

I had to make 2 small changes to the postman-test file: 
1. Remove the `[0]` from line 324 and 325
2. Expect the tag id to be any number greater than 0, instead of specifically expecting ids 2 and 3 (which changes from database to another and could lead to test failures.)

Please re-import the postman-test file into Postman again using the version in this repo, since it has minor changes, then run the collection, should all be green.


# Pagination

I paginated the tasks index usign Kaminari, the json payload will include these links:
`first` links to the first page
`last` links to the last page
`next` links to the next page
`prev` links to the previous page

this format is compliant with JSON API requirement.

To get a specific page of records, pass the query param `page`, e.g. `localhost:3000/api/v1/tasks?page=2`

# Errors

If an api operation is not successful, the errors are rendered as json and a status code 422 is returned.

# Notes

1. in postman-test.json, the request to create a tag (POST localhost:3000/v1/api/tags), the test will pass the first time, but on consequent tries, it will return a 422 code since the api doesn't allow duplicate tag titles.


