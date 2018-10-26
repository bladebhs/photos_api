# frozen_string_literal: true

module RequestSpecHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def authenticated_header
    user = User.create(email: 'test@test.com', password: '12345678')
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    {
      'Authorization': "Bearer #{token}"
    }
  end
end
