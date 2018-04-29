require 'spec_helper'
require 'dry_twitter/post/validate'

RSpec.describe DryTwitter::Post::Validate do
  subject {
    ->(params){ described_class.new.call(params) }
  }

  it 'will fail if no user logged' do
    result = subject.({ 'message' => '', :session => {}})

    expect(result.failure?).to be true
    expect(result.value).to eq('Forbidden for users that are not logged')
  end

  it 'will fail with message not filled' do
    result = subject.({ 'message' => '', :session => { :user_id => 22 } })

    expect(result.value[:message]).to be_truthy
    expect(result.value[:message].size).to eq(2)
    expect(result.value[:message]).to include("must be filled")
    expect(result.value[:message]).to include("size cannot be greater than 128")
  end

  it 'will fail with message length of 200' do
    result = subject.({ 'message' => 's' * 200, :session => { :user_id => 22 } })

    expect(result.value[:message]).to be_truthy
    expect(result.value[:message].size).to eq(1)
    expect(result.value[:message]).to include("size cannot be greater than 128")
  end

  it 'will not fail with message filled correctly' do
    result = subject.({ 'message' => 'some message', :session => { :user_id => 22 } })

    expect(result.value[:message]).to be_falsey
  end
end