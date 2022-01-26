# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ApplicationController, type: :request, clean: true, order: :random) do
  describe 'GET /' do
    it 'successful get response 200 OK' do
      get '/'

      expect(response).to(have_http_status(:ok))
      expect(response.body).to(include('Up and running!'))
    end
  end
end
