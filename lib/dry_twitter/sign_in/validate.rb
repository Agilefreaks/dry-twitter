require "dry/transaction/operation"

module DryTwitter
  module SignIn
    class Validate
      include Dry::Transaction::Operation

      def call(input)
        Success(input)
      end
    end
  end
end