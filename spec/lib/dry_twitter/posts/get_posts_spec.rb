require 'spec_helper'
require 'dry_twitter/posts/get_posts'

RSpec.describe DryTwitter::Posts::GetPosts do
  subject {
    ->(params, followed_users) {described_class.new(followed_users: followed_users).call(params)}
  }

  it 'will succeed' do
    followed_users = double
    allow(followed_users).to receive(:feed)

    result = subject.(33, followed_users)

    expect(result.success?).to be true
  end

  it 'will fail' do
    followed_users = double
    allow(followed_users).to receive(:feed).and_raise('DB error')

    result = subject.(33, followed_users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
