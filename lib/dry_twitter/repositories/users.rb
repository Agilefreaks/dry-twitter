require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class Users < DryTwitter::Repository[:users]
      commands :create

      def by_user_name(user_name)
        users.where(user_name: user_name).one
      end

      def listing(user_id)
        users.where {id.not(user_id)}.to_a
      end
    end
  end
end