module DryTwitter
  module Errors
    class NonExistingUserError < StandardError
      def initialize(msg = 'There is no user with the provided credentials')
        super(msg)
      end
    end
  end
end
