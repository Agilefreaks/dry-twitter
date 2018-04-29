require "dry/transaction/operation"
require "dry_twitter/import"
require 'dry-monads'
require 'armor'
require 'securerandom'

module DryTwitter
  module SignIn
    class Validate
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try() {
          user = input["user"]
          user_data = users.by_user_name(user["user_name"])
          raise 'There is no user with the provided credentials' if user_data.nil?

          hash = Armor.digest(user["password"], user_data["salt"])
          password_matches = (hash == user_data["password"])
          raise 'There is no user with the provided credentials' if !password_matches
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