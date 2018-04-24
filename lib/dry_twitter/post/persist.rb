require "dry/transaction/operation"
require 'dry_twitter/import'
require 'dry-monads'

module DryTwitter
  module Post
    class Persist
      include Dry::Transaction::Operation
      include Dry::Monads::Try::Mixin

      def call(input)
        result = Try() {
          puts 'persist'
        }

        if result.value?
          Success(input)
        else
          Failure(error_messages: [result.exception.message])
        end
      end
    end
  end
end