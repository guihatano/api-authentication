# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(User, type: :model, order: :random) do
  subject {
    described_class.new(email: 'email@test.com',
                        password: 'password',
                        name: 'User Test',
                        image: nil)
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end
