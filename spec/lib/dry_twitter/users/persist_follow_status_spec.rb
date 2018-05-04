require 'spec_helper'
require 'dry_twitter/users/persist_follow_status'

RSpec.describe DryTwitter::Users::PersistFollowStatus do
  subject {
    ->(params, followed_users) {described_class.new(followed_users: followed_users).call(params)}
  }

  it 'will delete follow status' do
    followed_users = double
    allow(followed_users).to receive(:followed_user).and_return("id" => 8)
    allow(followed_users).to receive(:delete).with(8)

    result = subject.({user_id: 33, followed_user_id: 48}, followed_users)

    expect(result.success?).to be true
    expect(result.value).to be 33
  end

  it 'will insert follow status' do
    followed_users = double
    allow(followed_users).to receive(:followed_user)
    allow(followed_users).to receive(:create).with(user_id: 33, followed_user_id: 48)

    result = subject.({user_id: 33, followed_user_id: 48}, followed_users)

    expect(result.success?).to be true
    expect(result.value).to be 33
  end

  it 'will fail' do
    followed_users = double
    allow(followed_users).to receive(:followed_user).and_raise('DB error')

    result = subject.({user_id: 33, followed_user_id: 48}, followed_users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
