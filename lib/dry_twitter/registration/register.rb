require "dry/transaction"

module DryTwitter
  module Registration
    class Register
      include Dry::Transaction(container: DryTwitter::Container)

      step :validate, with: "registration.validate"
      step :user_name_check, with: "registration.user_name_check"
      step :persist, with: "registration.persist"
    end
  end
end