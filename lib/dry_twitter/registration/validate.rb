require "dry/transaction/operation"

module DryTwitter
  module Registration
    class Validate
      include Dry::Transaction::Operation

      def call(input)
        Failure("not good")
      end
    end
  end
end