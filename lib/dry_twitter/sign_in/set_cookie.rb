require "dry/transaction/operation"

module DryTwitter
  module SignIn
    class SetCookie
      include Dry::Transaction::Operation

      def call(input)
        session = input[:session]
        user_name = input["user"]["user_name"]
        session[:user_name] = user_name

        Success(input)
      end
    end
  end
end