require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Post < DryTwitter::View::Controller
      configure do |config|
        config.template = "post"
      end

      def locals(options = {})
        super.merge(message: 'dummy message', errors: nil)
      end
    end
  end
end
