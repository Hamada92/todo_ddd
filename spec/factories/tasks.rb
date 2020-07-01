FactoryBot.define do
  factory :task, class: TaskRecord::Task do
    title { "Test" }
    aggregate_id { "5d78d6e0-a4c1-4575-abc9-d8e0d8b7d9a8" }
  end
end
