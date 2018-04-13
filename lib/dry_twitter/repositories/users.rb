require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class Users < DryTwitter::Repository[:users]
      commands :create

      def query(conditions)
        users.where(conditions).to_a
      end
    end
  end
end