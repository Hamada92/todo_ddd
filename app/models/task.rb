class Task < ApplicationRecord
  has_many :task_tags
  has_many :tags, through: :task_tags

  validates :title, presence: { message: "Task title is required" }
end
