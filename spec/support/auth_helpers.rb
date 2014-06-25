module AuthHelpers
  def auth_with user
    request.headers['X-ACCESS-TOKEN'] = "#{user.find_api_key.access_token}"
  end

  def clearToken
    request.headers['X-ACCESS-TOKEN'] = nil
  end
end