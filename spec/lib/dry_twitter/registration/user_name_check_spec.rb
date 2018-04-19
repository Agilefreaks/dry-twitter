require 'spec_helper'
require 'dry_twitter/registration/user_name_check'

class UsersRepo
  def by_user_name(user_name)
    if user_name == 'fail_user'
      raise 'DB error'
    elsif user_name == 'existing_user'
      [user_name]
    else
      []
    end
  end
end

RSpec.describe DryTwitter::Registration::UserNameCheck do
  subject {
    ->(params) {described_class.new(users: UsersRepo.new).call(params)}
  }

  it 'will succeed' do
    result = subject.({'user' => {'user_name' => 'test_user', 'password' => 'test_password'}})

    expect(result.success?).to be true
  end

  it 'will fail' do
    result = subject.({'user' => {'user_name' => 'fail_user', 'password' => 'test_password'}})

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end

  it 'will fail with existing user' do
    result = subject.({'user' => {'user_name' => 'existing_user', 'password' => 'test_password'}})

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('There is already a user with the provided user name')
  end
end