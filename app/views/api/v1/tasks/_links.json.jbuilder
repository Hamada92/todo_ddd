json.first api_v1_tasks_url(page: 1)
json.last api_v1_tasks_url(page:  collection.total_pages)

if collection.current_page != @task_views.total_pages
  json.next api_v1_tasks_url(page: @task_views.current_page + 1)
end

if !collection.first_page?
  json.previous api_v1_tasks_url(page: @task_views.current_page - 1)
end
