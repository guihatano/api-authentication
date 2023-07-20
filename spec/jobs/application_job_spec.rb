# frozen_string_literal: true

RSpec.describe(ApplicationJob, order: :random) do
  it 'is a subclass of ActiveJob::Base' do
    expect(described_class.superclass).to(eq(ActiveJob::Base))
  end
end
