json.data do
  json.partial! 'task', task: @task_view

  json.relationships do
    json.tags do
      json.data do
        json.array! @task_view.tags do |tag|
          json.id tag.first
          json.title tag.last
        end
      end
    end
  end
end
