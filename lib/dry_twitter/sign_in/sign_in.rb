require "dry/transaction"

module DryTwitter
  module SignIn
    class SignIn
      include Dry::Transaction(container: DryTwitter::Container)

      step :validate, with: "sign_in.validate"
      step :set_cookie, with: "sign_in.set_cookie"
    end
  end
end