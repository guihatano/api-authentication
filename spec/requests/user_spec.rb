require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:all) do
    @user = create(:user)
    @token = @user.generate_jwt
  end
  describe 'GET /show' do
    it 'successful get user' do
      headers = { 'Authorization' => "Token #{@token}" }
      get '/api/user', headers: headers

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /user' do
    it 'successful update user' do
      name = 'Updated User Name'
      headers = { 'ACCEPT' => 'application/json', 'Authorization' => "Token #{@token}" }
      put '/api/user', params: { user: { name: name } }, headers: headers

      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.keys).to eq(['user'])

      expect(parsed_response['user']).to have_key('name')
      expect(parsed_response['user']['name']).to eq(name)
    end

    it 'is not updated with an email nil' do
      headers = { 'ACCEPT' => 'application/json', 'Authorization' => "Token #{@token}" }
      put '/api/user', params: { user: { email: nil } }, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
