require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Dashboard < DryTwitter::View::Controller
      configure do |config|
        config.template = "dashboard"
      end

      def locals(options = {})
        super.merge(
          posts: options.dig(:posts),
          errors: options.dig(:errors)
        )
      end
    end
  end
end
