require "dry/transaction/operation"
require "dry_twitter/import"

module DryTwitter
  module SignIn
    class Validate
      include Dry::Transaction::Operation
      include DryTwitter::Import["repositories.users"]

      def call(input)
        begin
          result = users.query(user_name: input["user"]["user_name"], password: input["user"]["password"])
          result.size > 0 ? Success(input) : Failure("There is no user with the provided credentials")
        rescue
          Failure("An unexpected exception was raised while creating user database record")
        end
      end
    end
  end
end