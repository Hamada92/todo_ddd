# WorkDay To-Do app

This app requires ruby `2.6.5`, as specified in `.ruby-verson` file. Rails `5.2.4.1`

The app uses PostgreSQL as the Databse.

# Gems

I've used some gems to help with development:

1. Jbuilder for JSON responses.
2. Scenic to build SQL views in PostgreSQL (more on this below)
3. FactoryBot to create test objects.


I had to make 2 small changes to the postman-test file: 
1. Remove the `[0]` from line 323 and 325
2. Expect the tag id to be any number greater than 0, instead of specifically expecting ids 2 and 3 (which changes from database to another)

before running the tests, run `rake db:seed` to create an initial task and tag.
Please re-import the postman-test file into Postman again using the version in this repo, since it has minor changes.

# Models and API

I created 3 tables:
Tasks
Tags
TaskTags

Task and Tag has a many-to-many relationship.

In the migrations, you can see that I chose to create the task_tags table use pure SQL, that gives me more control over foreign keys and triggers (cascades)

Created a SQL view under `db/views` that gets tasks along with their associated tags using the hstore datatype in postgres (tag_id: tag_name), I find writing pure SQL more fun/powerful that using ActiveRecord, sometimes.


Under the `services` folder, I created a service object that encapsulates the logic for tagging a task, and tested separately in Rspec. 