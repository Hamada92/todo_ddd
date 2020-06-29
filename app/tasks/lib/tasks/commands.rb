module Tasks
  class SubmitTaskCommand
    include Command

    attr_accessor :title

    validates_presence_of :title
  end

  class UpdateTaskTitleCommand
    include Command

    attr_accessor :title, :aggregate_id

    validates_presence_of :title
  end
end
