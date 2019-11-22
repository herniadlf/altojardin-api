def error_response(key, status_code)
  status status_code
  {
    'error': key,
    'message': Messages.new.get_message(key)
  }.to_json
end
