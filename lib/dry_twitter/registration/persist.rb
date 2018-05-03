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
      include DryTwitter::Import["repositories.followed_users"]
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try() {
          user_id = users.transaction do |_|
            user_data = users.create(user_name: input[:user_name], password: input[:hash], salt: input[:salt])
            created_user_id = user_data["id"]
            followed_users.create(user_id: created_user_id, followed_user_id: created_user_id)
            created_user_id
          end

          {user_id: user_id, user_name: input[:user_name], session: input[:session]}
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