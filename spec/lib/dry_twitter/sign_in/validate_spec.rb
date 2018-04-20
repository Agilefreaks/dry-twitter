require 'spec_helper'
require 'dry_twitter/sign_in/validate'

class UsersRepo
  def by_user_name(user_name)
    if user_name == 'fail_user'
      raise 'DB error'
    elsif user_name == 'existing_user'
      {
          "user_name" => "existing_user",
          "password" => "bf8f4d7931e34515647fa8ea3cc6515bed3d4efc10b43d7c7ae9c83f4c7819bd2f31287f5d56309a592f690337888bf32b651eb9c41bee346aaed8d7c072addd",
          "salt" => "U3ObZh5jKGIKDpzugZnVEw=="
      }
    else
      nil
    end
  end
end

RSpec.describe DryTwitter::SignIn::Validate do
  subject {
    ->(params) {described_class.new(users: UsersRepo.new).call(params)}
  }

  it 'will succeed' do
    result = subject.({'user' => {'user_name' => 'existing_user', 'password' => 'test_password'}})

    expect(result.success?).to be true
  end

  it 'will fail' do
    result = subject.({'user' => {'user_name' => 'fail_user', 'password' => 'test_password'}})

    expect(result.failure?).to be true
    expect(result.value).to include('DB error')
    end

  it 'will fail with no user' do
    result = subject.({'user' => {'user_name' => 'no_user', 'password' => 'test_password'}})

    expect(result.failure?).to be true
    expect(result.value).to include('There is no user with the provided credentials')
  end

  it 'will fail with incorrect password' do
    result = subject.({'user' => {'user_name' => 'existing_user', 'password' => 'incorrect_password'}})

    expect(result.failure?).to be true
    expect(result.value).to include('There is no user with the provided credentials')
  end
end