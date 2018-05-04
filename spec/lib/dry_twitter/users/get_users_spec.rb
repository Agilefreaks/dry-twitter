require 'spec_helper'
require 'dry_twitter/users/get_users'

RSpec.describe DryTwitter::Users::GetUsers do
  subject {
    ->(params, users) {described_class.new(users: users).call(params)}
  }

  it 'will succeed' do
    users = double
    allow(users).to receive(:listing)

    result = subject.(33, users)

    expect(result.success?).to be true
  end

  it 'will fail' do
    users = double
    allow(users).to receive(:listing).and_raise('DB error')

    result = subject.(33, users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
