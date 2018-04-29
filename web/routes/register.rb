class DryTwitter::Web
  route "register" do |r|
    r.get do
      r.view "register"
    end

    r.post do
      r.resolve "registration.register" do |registration|
        registration.call(r.params) do |m|
          m.success do
            r.redirect "/"
          end

          m.failure do |errors|
            params_and_errors = r.params.merge({})
            params_and_errors[:errors] = errors
            r.view "register", input: params_and_errors
          end
        end
      end
    end
  end
end
