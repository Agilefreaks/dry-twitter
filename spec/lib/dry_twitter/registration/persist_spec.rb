require 'spec_helper'
require 'dry_twitter/registration/persist'

class UsersRepo
  def create(input)
    if input[:user_name] == 'fail_user'
      raise 'exception message'
    end
  end
end


RSpec.describe DryTwitter::Registration::Persist do
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
  end
end
