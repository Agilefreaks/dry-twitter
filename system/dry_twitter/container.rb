require "dry/web/container"
require "dry/system/components"

module DryTwitter
  class Container < Dry::Web::Container
    configure do
      config.name = :dry_twitter
      config.listeners = true
      config.default_namespace = "dry_twitter"
      config.auto_register = %w[lib/dry_twitter]
    end

    load_paths! "lib"
  end
end
