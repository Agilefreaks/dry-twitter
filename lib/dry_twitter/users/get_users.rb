require 'dry_twitter/import'
require 'dry-monads'
require 'dry_twitter/operation'
require 'rom/sql/error'

module DryTwitter
  module Users
    class GetUsers < Operation
      include DryTwitter::Import["repositories.users"]
      include Dry::Monads::Try::Mixin

      def call(user_id)
        result = Try(ROM::SQL::Error) {
          users.listing(user_id)
        }

        if result.value?
          Success(result.value)
        else
          Failure(error_messages: [result.exception.message])
        end
      end
    end
  end
end