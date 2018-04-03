# auto_register: false

require "rom-repository"
require "dry_twitter/container"
require "dry_twitter/import"

module DryTwitter
  class Repository < ROM::Repository::Root
    include Import.args["persistence.rom"]
  end
end
