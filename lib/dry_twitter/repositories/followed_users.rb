require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class FollowedUsers < DryTwitter::Repository[:followed_users]
      commands :create
    end
  end
end