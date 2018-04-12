require "dry/transaction/operation"
require 'dry-validation'

module DryTwitter
  module Registration
    class Validate
      include Dry::Transaction::Operation

      SCHEMA = Dry::Validation.Form do
        required(:user_name).filled(:str?, min_size?: 3)
        required(:password).filled(:str?, min_size?: 8)
        required(:confirm_password).filled(:str?, min_size?: 8)

        rule(confirm_password: %i(password confirm_password)) do |password, confirm_password|
          password.eql?(confirm_password)
        end
      end

      def call(input)
        result = SCHEMA.call(input["user"])

        if result.success?
          Success(input)
        else
          Failure(result.messages)
        end
      end
    end
  end
end