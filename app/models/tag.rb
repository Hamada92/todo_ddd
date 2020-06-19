class Tag < ApplicationRecord
  validates :title, presence: true
  validates_uniqueness_of :title

  before_save :set_code

  private

  def set_code
    self.code = title.gsub(" ", "_").downcase
  end
end
