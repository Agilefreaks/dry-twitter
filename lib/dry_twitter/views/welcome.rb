require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Welcome < DryTwitter::View::Controller
      configure do |config|
        config.template = "welcome"
      end

      def locals(options = {})
        super.merge(user_name: options[:session][:user_name])
      end
    end
  end
end
