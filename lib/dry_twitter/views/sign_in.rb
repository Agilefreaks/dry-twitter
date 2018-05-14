require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class SignIn < DryTwitter::View::Controller
      configure do |config|
        config.template = "sign_in"
      end

      def locals(options = {})
        super.merge(
          error: options.dig(:error)
        )
      end
    end
  end
end
