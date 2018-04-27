require "dry/transaction/operation"
require 'dry_twitter/import'
require 'dry-monads'
require 'armor'
require 'securerandom'

module DryTwitter
  module Registration
    class Persist
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try() {
          user = input["user"]
          salt = SecureRandom.base64(16)
          hash = Armor.digest(user["password"], salt)
          user_data = users.create(user_name: user["user_name"], password: hash, salt: salt)

          user["user_id"] = user_data["id"]
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