json.errors do
  json.array! @errors.full_messages do |message|
    json.partial! 'api/v1/errors/error', message: message
  end
end
