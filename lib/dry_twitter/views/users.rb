require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Users < DryTwitter::View::Controller
      configure do |config|
        config.template = "users"
      end

      def locals(options = {})
        super.merge(
          users: options.dig(:users),
          errors: options.dig(:errors)
        )
      end
    end
  end
end
