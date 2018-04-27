require 'spec_helper'
require 'dry_twitter/sign_in/set_cookie'

RSpec.describe DryTwitter::SignIn::SetCookie do
  subject {
    ->(params) {described_class.new.call(params)}
  }

  it 'set cookie' do
    result = subject.({:session => {}, 'user' => {'user_name' => 'un'}})

    expect(result.value[:session][:user_name]).to eq('un')
  end
end