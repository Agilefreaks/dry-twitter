module Persistence
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts, infer: true)
    end
  end
end