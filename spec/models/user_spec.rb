# frozen_string_literal: true

RSpec.describe(User, order: :random) do
  subject(:user) do
    described_class.new(
      email: 'email@test.com',
      password: 'password',
      name: 'User Test',
      image: nil
    )
  end

  it 'is valid with valid attributes' do
    expect(user).to(be_valid)
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to(be_valid)
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).not_to(be_valid)
  end
end
