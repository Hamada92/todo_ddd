json.data do
  json.partial! 'task', task: @task_view

  json.relationships do
    json.tags do
      json.data do
        json.array! @task_view.tags do |tag|
          json.partial! 'tag', tag: tag
        end
      end
    end
  end
end
