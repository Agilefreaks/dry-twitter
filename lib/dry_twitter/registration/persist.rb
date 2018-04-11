require "dry/transaction/operation"

module DryTwitter
  module Registration
    class Persist
      include Dry::Transaction::Operation

      def call(input)
        Success(input)
      end
    end
  end
end