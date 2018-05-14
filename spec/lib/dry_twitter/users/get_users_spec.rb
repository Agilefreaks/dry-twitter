require 'spec_helper'
require 'dry_twitter/users/get_users'

RSpec.describe DryTwitter::Users::GetUsers do
  subject {
    ->(params, users, followed_users) {described_class.new(users: users, followed_users: followed_users).call(params)}
  }

  it 'will succeed' do
    users = double
    allow(users).to receive(:listing).and_return [{'id' => 48}, {'id' => 60}]
    followed_users = double
    allow(followed_users).to receive(:get_followed_users).with(33).and_return [{'followed_user_id' => 48}]

    result = subject.(33, users, followed_users)

    expect(result.success?).to be true
    expect(result.value.count).to be 2
    first_value = result.value[0]
    expect(first_value[:id]).to be 48
    expect(first_value[:is_followed]).to be_truthy
    second_value = result.value[1]
    expect(second_value[:id]).to be 60
    expect(second_value[:is_followed]).to be_falsey
  end

  it 'will fail' do
    users = double
    allow(users).to receive(:listing).and_return [{'id' => 48}, {'id' => 60}]
    followed_users = double
    allow(followed_users).to receive(:get_followed_users).and_raise(ROM::SQL::Error.new(StandardError.new('DB error')))

    result = subject.(33, users, followed_users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
