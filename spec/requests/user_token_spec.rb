# frozen_string_literal: true

require 'rails_helper'

describe 'POST /user_token', type: :request do
  let!(:user) { create(:user) }
  let(:valid_params) do
    { 'email': user.email, 'password': user.password }
  end
  let(:invalid_params) do
    { 'email': 'test@gmail.com', 'password': '123' }
  end

  context 'when the user exists' do
    before do
      post '/user_token', params: { 'auth': valid_params }
    end

    it 'returns the token' do
      expect(json[:jwt]).not_to be_empty
    end
  end

  context 'when the user does not exist' do
    before do
      post '/user_token', params: { 'auth': invalid_params }
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
  end
end
