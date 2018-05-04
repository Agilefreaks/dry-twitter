require 'dry/transaction/operation'
require 'dry_twitter/import'
require 'dry-monads'

module DryTwitter
  module Users
    class GetUsers
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]
      include Dry::Monads::Try::Mixin

      def call(user_id)
        result = Try() {
          users.listing(user_id)
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