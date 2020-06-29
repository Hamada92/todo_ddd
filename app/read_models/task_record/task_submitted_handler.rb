module TaskRecord
  class TaskSubmittedHandler
    def call(ev)
      TaskRecord::Task.create!(
        aggregate_id: ev.data.fetch(:aggregate_id),
        title: ev.data.fetch(:title)
      )
    end
  end
end
