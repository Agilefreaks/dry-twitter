require "dry/transaction"

module DryTwitter
  module Registration
    class Register
      include Dry::Transaction(container: DryTwitter::Container)

      step :validate, with: "registration.validate"
      step :persist, with: "registration.persist"
    end
  end
end