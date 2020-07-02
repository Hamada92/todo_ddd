# frozen_string_literal: true

module Tasks
  class TaskCommand < Command
    attr_reader :title
    validates_presence_of :title, message: "Task Title can't be blank"

    def title=(title)
      @title = String(title)
    end
  end

  class SubmitTaskCommand < TaskCommand; end
  class UpdateTaskCommand < TaskCommand
    attr_reader :tags

    def tags=(tags)
      @tags = Array(tags)
    end
  end

  class DeleteTaskCommand < Command; end
end
