module Persistence
  module Relations
    class Users < ROM::Relation[:sql]
      schema(:users, infer: true) do
        associations do
          has_many :posts
          has_many :followed_users
        end
      end
    end
  end
end