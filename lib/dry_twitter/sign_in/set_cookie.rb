require "dry/transaction/operation"

module DryTwitter
  module SignIn
    class SetCookie
      include Dry::Transaction::Operation

      def call(input)
        user = input["user"]
        user_name = user["user_name"]
        user_id = user["user_id"]

        session = input[:session]
        session[:user_name] = user_name
        session[:user_id] = user_id

        Success(input)
      end
    end
  end
end