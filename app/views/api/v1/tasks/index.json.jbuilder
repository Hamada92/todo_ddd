json.data do
  json.array! @task_views do |task|
    json.partial! 'task', task: task

    json.relationships do
      json.tags do
        json.data do
          json.array! task.tags do |tag|
            json.partial! 'tag', tag: tag
          end
        end
      end
    end
  end
end

json.links do
  json.partial! 'links', collection: @task_views
end

json.meta do
  json.total_pages @task_views.total_pages
end
