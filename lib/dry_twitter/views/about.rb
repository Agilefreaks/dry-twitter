require "dry_twitter/view/controller"

module DryTwitter
  module Views
    class About < DryTwitter::View::Controller
      configure do |config|
        config.template = "about"
      end

      def locals(options = {})
        super.merge(
            authors: ['Cristi Catalan', 'Mr. Nobody']
        )
      end
    end
  end
end
