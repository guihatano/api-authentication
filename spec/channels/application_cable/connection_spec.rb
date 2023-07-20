# frozen_string_literal: true

RSpec.describe(ApplicationCable::Connection) do
  it 'successfully connects to the connection' do
    connect '/cable'
    expect { connection }.not_to(raise_error)
  end

  # it 'rejects connection if unauthorized' do
  #   # Implement the logic to test unauthorized connection if applicable
  #   # Example: connect with invalid credentials and expect rejection
  #   # connect "/cable", headers: { "Authorization" => "InvalidToken" }
  #   # expect(connection).to_not be_successful
  # end
end
