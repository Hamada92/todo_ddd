json.data do
  json.array! @tasks do |task|
    json.partial! 'task', task: task

    json.relationships do
      json.tags do
        json.data do
          json.array! task.tags do |tag|
            json.id tag.id.to_s
            json.title tag.title
          end
        end
      end
    end
  end
end
