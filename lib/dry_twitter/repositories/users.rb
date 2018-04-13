require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class Users < DryTwitter::Repository[:users]
      commands :create
    end
  end
end