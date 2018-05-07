require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class Posts < DryTwitter::Repository[:posts]
      commands :create
    end
  end
end