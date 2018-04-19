require 'spec_helper'
require 'dry_twitter/sign_in/validate'

class UsersRepo
  def correct_credentials(user_name, password)
    if user_name == 'fail_user'
      raise 'DB error'
    else
      user_name == 'existing_user' && password == 'test_password'
    end
  end
end

RSpec.describe DryTwitter::SignIn::Validate do
  subject {
    ->(params) {described_class.new(users: UsersRepo.new).call(params)}
  }

  it 'will succeed' do
    result = subject.({'user' => {'user_name' => 'test_user', 'password' => 'test_password'}})

    expect(result.success?).to be true
  end

  it 'will fail' do
    result = subject.({'user' => {'user_name' => 'fail_user', 'password' => 'test_password'}})

    p result.value

    expect(result.failure?).to be true
    expect(result.value).to include('DB error')
  end

  it 'will fail with existing user' do
    result = subject.({'user' => {'user_name' => 'existing_user', 'password' => 'test_password'}})

    expect(result.failure?).to be true
    expect(result.value).to include('There is no user with the provided credentials')
  end
end