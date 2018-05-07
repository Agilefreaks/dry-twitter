require 'spec_helper'
require 'dry_twitter/post/persist'

RSpec.describe DryTwitter::Post::Persist do
  subject {
    ->(params, posts) {described_class.new(posts: posts).call(params)}
  }

  it 'will succeed' do
    posts = double()
    allow(posts).to receive(:create)

    result = subject.({'message' => 'some message', :session => {"user_id" => 22}}, posts)

    expect(result.success?).to be true
  end

  it 'will fail' do
    posts = double()
    allow(posts).to receive(:create).and_raise(ROM::SQL::Error.new(StandardError.new('DB error')))

    result = subject.({'message' => 'some message', :session => {"user_id" => 22}}, posts)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
