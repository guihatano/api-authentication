# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Users', type: :request, clean: true, order: :random) do
  let(:user)  { create(:user) }
  let(:token) { user.generate_jwt }

  describe 'GET /show' do
    it 'successful get user' do
      headers = { 'Authorization' => "Token #{token}" }
      get '/api/user', headers: headers

      expect(response).to(have_http_status(:ok))
      expect(response.body).to(include(user.email))
    end
  end

  describe 'PUT /user' do
    let(:name) { 'Updated User Name' }

    it 'successful update user' do
      headers = { 'ACCEPT' => 'application/json', 'Authorization' => "Token #{token}" }
      put '/api/user', params: { user: { name: name } }, headers: headers

      parsed_response = JSON.parse(response.body)

      expect(response).to(have_http_status(:ok))
      expect(parsed_response.keys).to eq(['user'])
      expect(parsed_response['user']).to have_key('name')
      expect(parsed_response['user']['name']).to eq(name)
    end

    it 'is not updated with an email nil' do
      headers = { 'ACCEPT' => 'application/json', 'Authorization' => "Token #{token}" }
      put '/api/user', params: { user: { email: nil } }, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
