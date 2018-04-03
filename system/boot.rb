require "bundler/setup"

begin
  require "pry-byebug"
rescue LoadError
end

require_relative "dry_twitter/container"

DryTwitter::Container.finalize!

require "dry_twitter/web"
