require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Post < DryTwitter::View::Controller
      configure do |config|
        config.template = "post"
      end

      def locals(options = {})
        super.merge(
            message: options.dig(:input, "message"),
            errors: options.dig(:input, :errors)
        )
      end
    end
  end
end
