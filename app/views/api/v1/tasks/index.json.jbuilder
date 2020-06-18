json.data do
  json.array! @task_views do |task|
    json.partial! 'task', task: task

    json.relationships do
      json.tags do
        json.data do
          json.array! task.tags do |tag|
            json.id tag.first
            json.title tag.last
          end
        end
      end
    end
  end
end
