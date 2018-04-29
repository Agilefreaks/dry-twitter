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
          salt = SecureRandom.base64(16)
          hash = Armor.digest(input["user"]["password"], salt)
          users.create(user_name: input["user"]["user_name"], password: hash, salt: salt)
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