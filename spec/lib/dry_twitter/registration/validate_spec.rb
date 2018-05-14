require 'spec_helper'
require 'dry_twitter/registration/validate'

RSpec.describe DryTwitter::Registration::Validate do
  subject {
    ->(params, users = double) {described_class.new(users: users).call(params)}
  }

  it 'will fail with empty input' do
    result = subject.({ 'user' => { 'user_name' => '', 'password' => '', 'confirm_password' => '' } })

    expect(result.failure?).to be true
  end

  it 'will fail with user name not filled' do
    result = subject.({ 'user' => { 'user_name' => '' } })

    expect(result.value[:user_name]).to be_truthy
    expect(result.value[:user_name].size).to eq(3)
    expect(result.value[:user_name]).to include("must be filled")
    expect(result.value[:user_name]).to include("size cannot be less than 3")
  end

  it 'will fail with user name length of 2' do
    users = double
    allow(users).to receive(:by_user_name)

    result = subject.({ 'user' => { 'user_name' => 'Cr' } }, users)

    expect(result.value[:user_name]).to be_truthy
    expect(result.value[:user_name].size).to eq(1)
    expect(result.value[:user_name]).to include("size cannot be less than 3")
  end

  it 'will not fail with user name filled correctly' do
    users = double
    allow(users).to receive(:by_user_name)

    result = subject.({ 'user' => { 'user_name' => 'Cristi' } }, users)

    expect(result.value[:user_name]).to be_falsey
  end

  it 'will fail with password not filled' do
    result = subject.({ 'user' => { 'password' => '' } })

    expect(result.value[:password]).to be_truthy
    expect(result.value[:password].size).to eq(2)
    expect(result.value[:password]).to include("must be filled")
    expect(result.value[:password]).to include("size cannot be less than 8")
  end

  it 'will fail with password length of 2' do
    result = subject.({ 'user' => { 'password' => 'pass' } })

    expect(result.value[:password]).to be_truthy
    expect(result.value[:password].size).to eq(1)
    expect(result.value[:password]).to include("size cannot be less than 8")
  end

  it 'will not fail with password filled corrctly' do
    result = subject.({ 'user' => { 'password' => 'password' } })

    expect(result.value[:password]).to be_falsey
  end

  it 'will fail with password and confirm password different' do
    users = double
    allow(users).to receive(:by_user_name).with('Cristi')

    result = subject.({ 'user' => { 'user_name' => 'Cristi', 'password' => 'password1', 'confirm_password' => 'password2' } }, users)

    expect(result.value[:confirm_password]).to be_truthy
  end

  it 'will fail with existing user' do
    users = double
    allow(users).to receive(:by_user_name).with('existing_user').and_return('user data')

    result = subject.({'user' => {'user_name' => 'existing_user', 'password' => 'test_password'}}, users)

    expect(result.failure?).to be true
    expect(result.value[:user_name]).to include('there is already a user with the provided user name')
  end
end