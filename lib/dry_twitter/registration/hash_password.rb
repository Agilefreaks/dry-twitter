require 'dry-monads'
require 'armor'
require 'securerandom'
require 'dry_twitter/operation'

module DryTwitter
  module Registration
    class HashPassword < Operation
      def call(input)
        user = input["user"]
        salt = SecureRandom.base64(16)
        hash = Armor.digest(user["password"], salt)

        Success({user_name: user["user_name"], hash: hash, salt: salt, session: input[:session]})
      end
    end
  end
end