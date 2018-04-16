require "dry/transaction/operation"

module DryTwitter
  module SignIn
    class SetCookie
      include Dry::Transaction::Operation

      def call(input)
        env = input[:env]
        env['rack.session'][:user_name] = input["user"]["user_name"]

        Success(input)
      end
    end
  end
end