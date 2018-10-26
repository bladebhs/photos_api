# frozen_string_literal: true

require 'rails_helper'

describe 'Users API', type: :request do
  describe 'POST /auth/register' do
    let(:valid_user) { { user: attributes_for(:user) } }
    let(:invalid_user) { { user: { email: 'test@test.com' } } }

    context 'with valid parameters' do
      before do
        post '/auth/register', params: valid_user
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/auth/register', params: invalid_user
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end