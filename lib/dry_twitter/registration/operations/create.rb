require "dry-container"
require "dry/transaction"
require "dry/transaction/operation"

module DryTwitter
  module Operations
    class Create
      include Dry::Transaction::Operation

      def call(input)
        Success(name: input["user_name"])
      end
    end
  end
end