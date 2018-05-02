module Persistence
  module Relations
    class FollowedUsers < ROM::Relation[:sql]
      schema(:followed_users, infer: true) do
        associations do
          belongs_to :users, as: :followed_users, foreign_key: :followed_user_id
          belongs_to :users, as: :users, foreign_key: :user_id
        end
      end
    end
  end
end