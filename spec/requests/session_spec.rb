# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before(:all) do
    @user = create(:user)
  end

  describe 'POST /api/auth/login' do
    it 'successful sign in with write parameters' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/api/auth/login', params: { email: @user.email, password: 'password' }, headers: headers

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.keys).to eq(['user'])

      expect(parsed_response['user']).to have_key('token')

      @token = parsed_response['user']['token']
    end

    it 'responds 422 with wrong email sign in' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/api/auth/login', params: { email: 'not@registered.com', password: 'password' }, headers: headers

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'responds 422 with wrong password sign in' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/api/auth/login', params: { email: @user.email, password: 'wrong-password' }, headers: headers

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /api/user' do
    it 'successful get response 200 OK when passing valid authorization token' do
      headers = { 'Authorization' => "Token #{@user.generate_jwt}" }
      get '/api/user', headers: headers

      expect(response).to have_http_status(:ok)
    end
  end
end
