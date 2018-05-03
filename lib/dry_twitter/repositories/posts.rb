require 'rom-repository'
require 'dry_twitter/repository'

module DryTwitter
  module Repositories
    class Posts < DryTwitter::Repository[:posts]
      commands :create

      def feed(user_id)
        posts.where(user_id: user_id).to_a
      end
    end
  end
end