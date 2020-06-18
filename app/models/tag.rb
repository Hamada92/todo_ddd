class Tag < ApplicationRecord
  validates :title, presence: true

  before_save :set_code

  private

  def set_code
    self.code = title.downcase
  end
end
