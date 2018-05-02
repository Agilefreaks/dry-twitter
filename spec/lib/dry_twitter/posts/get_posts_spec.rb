require 'spec_helper'
require 'dry_twitter/posts/get_posts'

RSpec.describe DryTwitter::Posts::GetPosts do
  subject {
    ->(params, posts) {described_class.new(posts: posts).call(params)}
  }

  it 'will succeed' do
    posts = double()
    allow(posts).to receive(:feed)

    result = subject.(33, posts)

    expect(result.success?).to be true
  end

  it 'will fail' do
    posts = double()
    allow(posts).to receive(:feed).and_raise('DB error')

    result = subject.(33, posts)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
