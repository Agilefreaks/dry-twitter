require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Register < DryTwitter::View::Controller
      configure do |config|
        config.template = "register"
      end
    end
  end
end
