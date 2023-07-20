# frozen_string_literal: true

RSpec.describe(ApplicationController, clean: true, order: :random) do
  describe 'GET /' do
    it 'successful get response 200 OK' do
      get '/'

      expect(response).to(have_http_status(:ok))
      expect(response.body).to(include('Up and running!'))
    end
  end

  describe 'authentication' do
    context 'when unauthenticated request' do
      it 'requires authentication for other endpoints' do
        get '/api/user'
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
