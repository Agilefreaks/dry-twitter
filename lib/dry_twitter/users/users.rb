require "dry/transaction"

module DryTwitter
  module Users
    class Users
      include Dry::Transaction(container: DryTwitter::Container)

      step :get_users, with: "users.get_users"
    end
  end
end