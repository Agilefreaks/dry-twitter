require "dry/transaction"

module DryTwitter
  module Post
    class Post
      include Dry::Transaction(container: DryTwitter::Container)

      step :validate, with: "post.validate"
    end
  end
end