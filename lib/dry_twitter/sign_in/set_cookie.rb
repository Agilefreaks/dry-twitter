require "dry/transaction/operation"

module DryTwitter
  module SignIn
    class SetCookie
      include Dry::Transaction::Operation

      def call(input)
        Success(input)
      end
    end
  end
end