require 'dry_twitter/operation'

module DryTwitter
  module SignIn
    class SetCookie < Operation
      def call(input)
        user_name = input[:user_name]
        user_id = input[:user_id]

        session = input[:session]
        session[:user_name] = user_name
        session[:user_id] = user_id

        Success(input)
      end
    end
  end
end