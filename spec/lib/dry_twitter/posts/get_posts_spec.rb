require 'spec_helper'
require 'dry_twitter/posts/get_posts'

User = Struct.new(:followed_user)
FollowedUser = Struct.new(:user_name, :posts)
Post = Struct.new(:created_at, :message)

RSpec.describe DryTwitter::Posts::GetPosts do
  subject {
    ->(params, followed_users) {described_class.new(followed_users: followed_users).call(params)}
  }

  it 'will succeed' do
    user1 = User.new(FollowedUser.new('Lucy', [Post.new(Time.new(2018, 5, 20), 'message no two'),
                                               Post.new(Time.new(2018, 6, 20), 'message no one')]))
    user2 = User.new(FollowedUser.new('Karen', [Post.new(Time.new(2018, 3, 20), 'message no four'),
                                                Post.new(Time.new(2018, 4, 20), 'message no three')]))

    followed_users = double
    allow(followed_users).to receive(:feed).with(33).and_return([user1, user2])

    result = subject.(33, followed_users)

    p result
    expect(result.success?).to be true
    expect(result.value.length).to be 4
    expect(result.value[0][:message]).to eq('message no one')
    expect(result.value[1][:message]).to eq('message no two')
    expect(result.value[2][:message]).to eq('message no three')
    expect(result.value[3][:message]).to eq('message no four')
  end

  it 'will fail' do
    followed_users = double
    allow(followed_users).to receive(:feed).and_raise(ROM::SQL::Error.new(StandardError.new('DB error')))

    result = subject.(33, followed_users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
