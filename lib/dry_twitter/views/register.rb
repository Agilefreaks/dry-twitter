require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Register < DryTwitter::View::Controller
      configure do |config|
        config.template = "register"
      end

      def locals(options = {})
        super.merge(
          user: options.dig(:input, "user"),
          errors: options.dig(:input, :errors)
        )
      end
    end
  end
end
