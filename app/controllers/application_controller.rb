# frozen_string_literal: true

class ApplicationController < ActionController::API


  private

  def new_aggregate_id
    SecureRandom.uuid
  end
end
