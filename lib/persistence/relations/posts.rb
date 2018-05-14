module Persistence
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts, infer: true) do
        associations do
          belongs_to :users, as: :user
        end
      end
    end
  end
end