require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Register < DryTwitter::View::Controller
      configure do |config|
        config.template = "register"
      end

      def locals(options = {})
        if options.size > 0
          super.merge(
              user: options[:input]["user"],
              errors: options[:input][:errors]
          )
        else
          super.merge(user: nil, errors: nil)
        end
      end
    end
  end
end
