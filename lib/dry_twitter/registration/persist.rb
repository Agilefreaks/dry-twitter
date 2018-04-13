require "dry/transaction/operation"
require "dry_twitter/import"

module DryTwitter
  module Registration
    class Persist
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]

      def call(input)
        begin
          users.create(user_name: input["user"]["user_name"], password: input["user"]["password"])
          Success(input)
        rescue Exception
          Failure("An unexpected exception was raised while creating user database record")
        end
      end
    end
  end
end