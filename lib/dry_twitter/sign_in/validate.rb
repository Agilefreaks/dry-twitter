require "dry/transaction/operation"
require "dry_twitter/import"
require 'dry-monads'

module DryTwitter
  module SignIn
    class Validate
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try(){
          user = input["user"]
          correct_credentials = users.correct_credentials(user["user_name"], user["password"])
          raise 'There is no user with the provided credentials' if correct_credentials
        }

        if result.value?
          Success(input)
        else
          Failure(result.exception.message)
        end
      end
    end
  end
end