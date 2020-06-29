module TaskRecord
  class TaskSubmittedHandler
    def call(ev)
      TaskRecord::Task.find_by!(
        aggregate_id: ev.data.fetch(:aggregate_id)).update!(title: ev.data.fetch(:title))
    end
  end
end
