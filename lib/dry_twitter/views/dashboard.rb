require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class Dashboard < DryTwitter::View::Controller
      configure do |config|
        config.template = "dashboard"
      end
    end
  end
end
