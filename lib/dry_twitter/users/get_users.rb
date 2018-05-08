require 'dry_twitter/import'
require 'dry-monads'
require 'dry_twitter/operation'
require 'rom/sql/error'

module DryTwitter
  module Users
    class GetUsers < Operation
      include DryTwitter::Import["repositories.users", "repositories.followed_users"]
      include Dry::Monads::Try::Mixin

      def call(user_id)
        result = Try(ROM::SQL::Error) {
          followed_users_ids = followed_users
                                   .get_followed_users(user_id)
                                   .map {|followed_user| followed_user["followed_user_id"]}
          users
              .listing(user_id)
              .map {|user| {
                  id: user["id"],
                  user_name: user["user_name"],
                  is_followed: followed_users_ids.include?(user["id"])
              }}
        }

        if result.value?
          Success(result.value)
        else
          Failure(error_messages: [result.exception.message])
        end
      end
    end
  end
end