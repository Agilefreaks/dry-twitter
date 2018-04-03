module Test
  module DatabaseHelpers
    module_function

    def rom
      DryTwitter::Container["persistence.rom"]
    end

    def db
      DryTwitter::Container["persistence.db"]
    end
  end
end
