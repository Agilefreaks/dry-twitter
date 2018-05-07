require 'dry-validation'
require 'dry_twitter/import'

module DryTwitter
  module Registration
    class Validate < Operation
      include DryTwitter::Import["repositories.users"]

      SCHEMA = Dry::Validation.Form do
        configure do
          config.messages_file = Container.root.join("en.yml")

          option :users_repo

          def unique_user_name?(value)
            user_data = users_repo.by_user_name(value)
            user_data.nil?
          end
        end

        required(:user_name).filled(:str?, :unique_user_name?, min_size?: 3)
        required(:password).filled(:str?, min_size?: 8)
        required(:confirm_password).filled(:str?, min_size?: 8)

        rule(confirm_password: %i(password confirm_password)) do |password, confirm_password|
          password.eql?(confirm_password)
        end
      end

      def call(input)
        result = SCHEMA.with(users_repo: users).call(input["user"])

        if result.success?
          Success(input)
        else
          Failure(result.messages)
        end
      end
    end
  end
end
