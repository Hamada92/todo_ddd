class TaskTag < ApplicationRecord
  belongs_to :task, required: true
  belongs_to :tag, required: true
end
