require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Register < DryTwitter::View::Controller
      configure do |config|
        config.template = "register"
      end

      def locals(options = {})
        super.merge(
            user: {'user_name'=>'Zed1'}
        )
      end
    end
  end
end
