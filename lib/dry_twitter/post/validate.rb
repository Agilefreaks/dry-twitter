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
        result = SCHEMA.call(input) unless input[:session][:user_id].nil?

        if result.nil?
          Failure('Forbidden for users that are not logged')
        elsif result.success?
          Success(input)
        else
          Failure(result.messages)
        end
      end
    end
  end
end