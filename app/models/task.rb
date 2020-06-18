class Task < ApplicationRecord
  validates :title, presence: true

  has_many :task_tags
  has_many :tags, through: :task_tags
end
