require "dry/transaction/operation"
require 'dry-validation'

module DryTwitter
  module Post
    class Validate
      include Dry::Transaction::Operation

      SCHEMA = Dry::Validation.Form do
        required(:message).filled(max_size?: 128)
      end

      def call(input)
        result = SCHEMA.call(input)

        if result.success?
          Success(input)
        else
          Failure(result.messages)
        end
      end
    end
  end
end