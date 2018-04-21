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
        Try() {
          salt = SecureRandom.base64(16)
          hash = Armor.digest(input["user"]["password"], salt)
          users.create(user_name: input["user"]["user_name"], password: hash, salt: salt)
        }.to_result
      end
    end
  end
end