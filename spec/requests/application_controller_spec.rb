# frozen_string_literal: true

RSpec.describe(ApplicationController, clean: true, order: :random) do
  describe 'GET /' do
    it 'successful get response 200 OK' do
      get '/'

      expect(response).to(have_http_status(:ok))
      expect(response.body).to(include('Up and running!'))
    end
  end
end
