require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class FollowedUsers < DryTwitter::Repository[:followed_users]
      commands :create, delete: :by_pk

      def feed(user_id)
        followed_users.where(user_id: user_id).combine(followed_user: :posts).to_a
      end

      def followed_user(user_id, followed_user_id)
        followed_users.where(user_id: user_id, followed_user_id: followed_user_id).one
      end

      def get_followed_users(id)
        followed_users.where {user_id.in(id) & followed_user_id.not(id)}.to_a
      end
    end
  end
end