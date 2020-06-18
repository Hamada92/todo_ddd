json.errors do
  json.array! @errors.full_messages do |message|
    json.partial! 'error', message: message
  end
end
