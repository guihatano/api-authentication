# frozen_string_literal: true

RSpec.describe('Sessions', clean: true, order: :random) do
  let(:user) { create(:user) }

  describe 'POST /api/auth/login' do
    let(:headers) { { 'ACCEPT' => 'application/json' } }

    it 'successful sign in with write parameters' do
      post '/api/auth/login', params: { email: user.email, password: 'password' }, headers: headers
      parsed_response = JSON.parse(response.body)

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:ok)
      expect(parsed_response.keys).to eq(['user'])
      expect(parsed_response['user']).to have_key('token')
      expect(parsed_response['user']['token']).to be_a(String)
    end

    it 'responds 422 with wrong email sign in' do
      post '/api/auth/login', params: { email: 'not@registered.com', password: 'password' }, headers: headers

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'responds 422 with wrong password sign in' do
      post '/api/auth/login', params: { email: user.email, password: 'wrong-password' }, headers: headers

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /api/user' do
    it 'successful get response 200 OK when passing valid authorization token' do
      headers = { 'Authorization' => "Token #{user.generate_jwt}" }
      get '/api/user', headers: headers

      expect(response).to have_http_status(:ok)
    end

    it 'get unauthorized when passing wrong token' do
      headers = { 'Authorization' => 'Token xyz' }
      get '/api/user', headers: headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
