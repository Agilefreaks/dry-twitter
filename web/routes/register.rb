class DryTwitter::Web
  route "register" do |r|
    r.get do
      r.view "register"
    end

    r.post do
      r.resolve "registration.register" do |registration|
        registration.(r.params) do |m|
          m.success do
            r.redirect "/"
          end

          m.failure :validate do |error|
            r.view "register", params: r.params["user"]
          end

          m.failure do |error|
            p error
          end
        end
      end
    end
  end
end
