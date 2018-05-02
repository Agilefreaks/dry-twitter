require 'dry/transaction/operation'
require 'dry_twitter/import'
require 'dry-monads'

module DryTwitter
  module Posts
    class GetPosts
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.posts"]
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try() {
          posts.feed(input)
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