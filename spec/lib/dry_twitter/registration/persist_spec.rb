require 'spec_helper'
require 'dry_twitter/registration/persist'

RSpec.describe DryTwitter::Registration::Persist do
  subject {
    ->(params, users, followed_users) {described_class.new(users: users, followed_users: followed_users).call(params)}
  }

  it 'will succeed' do
    users = double()
    allow(users).to receive(:transaction).and_return(33)
    allow(users).to receive(:create)

    followed_users = double()
    allow(followed_users).to receive(:create)

    result = subject.({'user' => {'user_name' => 'test_user', 'password' => 'test_password'}}, users, followed_users)

    expect(result.success?).to be true
    expect(result.value[:user_id]).to be 33
  end

  it 'will fail' do
    users = double()
    allow(users).to receive(:transaction).and_raise(ROM::SQL::Error.new(StandardError.new('DB error')))
    allow(users).to receive(:create)

    followed_users = double()
    allow(followed_users).to receive(:create)

    result = subject.({'user' => {'user_name' => 'fail_user', 'password' => 'test_password'}}, users, followed_users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
