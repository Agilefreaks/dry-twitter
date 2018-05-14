require 'dry_twitter/import'
require 'dry-monads'
require 'dry_twitter/operation'
require 'rom/sql/error'

module DryTwitter
  module Posts
    class GetPosts < Operation
      include DryTwitter::Import["repositories.followed_users"]
      include Dry::Monads::Try::Mixin

      def call(user_id)
        result = Try(ROM::SQL::Error) {
          result = []
          followed_users.feed(user_id).map do |user|
            result << user.followed_user.posts.map do |post|
              {
                  user_name: user.followed_user['user_name'],
                  created_at: post['created_at'],
                  message: post['message']
              }
            end
          end
          result.flatten!.sort! {|x, y| -(x[:created_at] <=> y[:created_at])}
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