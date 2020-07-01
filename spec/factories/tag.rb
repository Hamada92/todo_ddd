FactoryBot.define do
  factory :tag, class: TagRecord::Tag do
    title { "Test Tag" }
  end
end
