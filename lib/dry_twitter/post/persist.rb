require 'dry_twitter/import'
require 'dry_twitter/operation'
require 'dry-monads'

module DryTwitter
  module Post
    class Persist < Operation
      include DryTwitter::Import["repositories.posts"]
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try() {
          posts.create(message: input["message"], user_id: input[:session][:user_id])
        }

        if result.value?
          Success(input)
        else
          Failure(error_messages: [result.exception.message])
        end
      end
    end
  end
end