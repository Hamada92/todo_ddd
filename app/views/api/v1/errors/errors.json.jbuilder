json.errors do
  json.array! @errors.messages.values do |message|
    json.partial! 'api/v1/errors/error', message: message
  end
end
