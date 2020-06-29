module Tasks
  class SubmitTaskCommand
    include Command

    attr_accessor :title

    validates_presence_of :title
  end
end
