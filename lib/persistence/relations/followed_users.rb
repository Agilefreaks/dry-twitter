module Persistence
  module Relations
    class FollowedUsers < ROM::Relation[:sql]
      schema(:followed_users, infer: true)
    end
  end
end