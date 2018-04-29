require 'spec_helper'
require 'dry_twitter/registration/user_name_check'

RSpec.describe DryTwitter::Registration::UserNameCheck do
  subject {
    ->(params, users) {described_class.new(users: users).call(params)}
  }

  it 'will succeed' do
    users = double()
    allow(users).to receive(:by_user_name)

    result = subject.({'user' => {'user_name' => 'test_user', 'password' => 'test_password'}}, users)

    expect(result.success?).to be true
  end

  it 'will fail' do
    users = double()
    allow(users).to receive(:by_user_name).and_raise("DB error")

    result = subject.({'user' => {'user_name' => 'fail_user', 'password' => 'test_password'}}, users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end

  it 'will fail with existing user' do
    users = double()
    allow(users).to receive(:by_user_name).and_return('existing_user')

    result = subject.({'user' => {'user_name' => 'existing_user', 'password' => 'test_password'}}, users)

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('There is already a user with the provided user name')
  end
end
