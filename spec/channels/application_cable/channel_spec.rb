# frozen_string_literal: true

RSpec.describe(ApplicationCable::Channel) do
  it 'successfully subscribes to the channel' do
    subscribe
    expect(subscription).to be_confirmed
  end

  # it 'rejects subscription if unauthorized' do
  #   # Implement the logic to test unauthorized subscription if applicable
  #   # Example: subscribe with invalid credentials and expect rejection
  #   # subscribe headers: { "Authorization": "InvalidToken" }
  #   # expect(subscription).to be_rejected
  # end
end
