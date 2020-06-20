class Tag < ApplicationRecord
  validates :title, presence: { message: "Tag title is required" }
  validates_uniqueness_of :title, message: "Tag title already exists"

  before_save :set_code

  private

  def set_code
    self.code = title.gsub(" ", "_").downcase
  end
end
