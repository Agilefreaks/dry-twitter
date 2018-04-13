require "dry/transaction/operation"
require "dry_twitter/import"

module DryTwitter
  module Registration
    class Persist
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]

      def call(input)
        users.create(user_name: input["user"]["user_name"], password: input["user"]["password"])
        Success(input)
      end
    end
  end
end