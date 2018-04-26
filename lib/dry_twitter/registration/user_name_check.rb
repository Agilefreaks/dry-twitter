require 'dry/transaction/operation'
require 'dry_twitter/import'
require 'dry-monads'

module DryTwitter
  module Registration
    class UserNameCheck
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try() {
          user_data = users.by_user_name(input["user"]["user_name"])
          raise 'There is already a user with the provided user name' unless user_data.nil?
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
