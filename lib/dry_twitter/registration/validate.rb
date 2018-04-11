require "dry/transaction/operation"
require 'dry-validation'

module DryTwitter
  module Registration
    class Validate
      include Dry::Transaction::Operation

      def call(input)
        schema = Dry::Validation.Schema do
          required("user_name").filled(:str?, min_size?: 3)
          required("password").filled(:str?, min_size?: 8)
          required("confirm_password").filled(:str?, min_size?: 8)
        end

        result = schema.call(input["user"])

        if (result.success?)
          Success(input)
        else
          Failure(result.messages)
        end
      end
    end
  end
end