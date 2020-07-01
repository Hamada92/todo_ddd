module TaskRecord
  class TaskDeletedHandler
    def call(ev)
      TaskRecord::Task.find_by!(
        aggregate_id: ev.data.fetch(:aggregate_id)).update!(deleted_at: Time.zone.now)
    end
  end
end
