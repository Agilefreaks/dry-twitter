require "dry/transaction/operation"
require 'dry-monads'
require 'armor'
require 'securerandom'

module DryTwitter
  module Registration
    class HashPassword
      include Dry::Transaction::Operation

      def call(input)
        user = input["user"]
        salt = SecureRandom.base64(16)
        hash = Armor.digest(user["password"], salt)

        Success({user_name: user["user_name"], hash: hash, salt: salt, session: input[:session]})
      end
    end
  end
end