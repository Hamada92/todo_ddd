require 'active_model'

class Command
  ValidationError = Class.new(StandardError)

  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :aggregate_id

  validates_presence_of :aggregate_id, message: "aggregate_id can't be blank"

  def validate!
    raise ValidationError, errors unless valid?
  end
end
