require 'spec_helper'
require 'dry_twitter/registration/hash_password'

RSpec.describe DryTwitter::Registration::HashPassword do
  subject {
    ->(params) {described_class.new.call(params)}
  }

  it 'will hash' do
    result = subject.({'user' => {'user_name' => 'test_user', 'password' => 'test_password'}})

    expect(result.value[:user_name]).to eq 'test_user'
    expect(result.value.key?(:hash)).to be true
    expect(result.value.key?(:salt)).to be true
    expect(result.value.key?(:session)).to be true
  end
end
