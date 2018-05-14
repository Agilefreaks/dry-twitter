require "dry/transaction"

module DryTwitter
  module Users
    class FollowUnfollow
      include Dry::Transaction(container: DryTwitter::Container)

      step :persist_follow_status, with: "users.persist_follow_status"
      step :get_users, with: "users.get_users"
    end
  end
end