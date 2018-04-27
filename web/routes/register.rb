class DryTwitter::Web
  route "register" do |r|
    r.get do
      r.view "register"
    end

    r.post do
      r.resolve "registration.register" do |registration|
        r.params[:session] = session
        registration.call(r.params) do |m|
          m.success do
            r.redirect "dashboard"
          end

          m.failure do |errors|
            r.params[:errors] = errors
            r.view "register", input: r.params
          end
        end
      end
    end
  end
end
