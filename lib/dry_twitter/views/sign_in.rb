require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class SignIn < DryTwitter::View::Controller
      configure do |config|
        config.template = "sign_in"
      end

      def locals(options = {})
        super.merge(
          user: options.dig(:input, "user"),
          errors: options.dig(:input ,:errors)
        )
      end
    end
  end
end
