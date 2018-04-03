require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Welcome < DryTwitter::View::Controller
      configure do |config|
        config.template = "welcome"
      end
    end
  end
end
