module Persistence
  module Relations
    class FollowedUsers < ROM::Relation[:sql]
      schema(:followed_users, infer: true) do
        associations do
          belongs_to :users, as: :user, foreign_key: :user_id
          belongs_to :users, as: :followed_user, foreign_key: :followed_user_id
        end
      end
    end
  end
end