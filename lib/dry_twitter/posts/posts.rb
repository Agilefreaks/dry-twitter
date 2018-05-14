require "dry/transaction"

module DryTwitter
  module Posts
    class Posts
      include Dry::Transaction(container: DryTwitter::Container)

      step :get_posts, with: "posts.get_posts"
    end
  end
end