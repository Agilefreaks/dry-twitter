require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class Users < DryTwitter::Repository[:users]
      commands :create

      def by_user_name(user_name)
        users.where(user_name: user_name).to_a
      end

      def correct_credentials(user_name, password)
        users.where(user_name: user_name, password: password).one.nil?
      end
    end
  end
end