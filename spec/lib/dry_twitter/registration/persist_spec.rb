require 'spec_helper'
require 'dry_twitter/registration/persist'

RSpec.describe DryTwitter::Registration::Persist do
  subject {
    ->(params, users) {described_class.new(users: users).call(params)}
  }

  it 'will succeed' do
    users = double()
    allow(users).to receive(:create).and_return({"id" => 33})

    result = subject.({'user' => {'user_name' => 'test_user', 'password' => 'test_password'}}, users)

    expect(result.success?).to be true
    expect(result.value["user"]["user_id"]).to be 33
  end

  it 'will fail' do
    users = double()
    allow(users).to receive(:create).and_raise('DB error')

    result = subject.({'user' => {'user_name' => 'fail_user', 'password' => 'test_password'}}, users)

    puts result

    expect(result.failure?).to be true
    expect(result.value[:error_messages]).to be_truthy
    expect(result.value[:error_messages]).to include('DB error')
  end
end
