class TaskTag < ApplicationRecord
  belongs_to :task, required: true
  belongs_to :tag, required: true

  validates_uniqueness_of :task_id, scope: [:tag_id]
end
