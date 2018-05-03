require "dry/transaction"

module DryTwitter
  module Registration
    class Register
      include Dry::Transaction(container: DryTwitter::Container)

      step :validate, with: "registration.validate"
      step :hash_password, with: "registration.hash_password"
      step :persist, with: "registration.persist"
      step :set_cookie, with: "sign_in.set_cookie"
    end
  end
end