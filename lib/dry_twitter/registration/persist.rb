require "dry/transaction/operation"
require "dry_twitter/import"
require "dry-monads"

module DryTwitter
  module Registration
    class Persist
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]
      include Dry::Monads::Try::Mixin

      def call(input)
        Try() {users.create(user_name: input["user"]["user_name"], password: input["user"]["password"])}.to_result
      end
    end
  end
end