class DryTwitter::Web
  route "sign_in" do |r|
    r.get do
      r.view "sign_in"
    end

    r.post do
      r.resolve "sign_in.sign_in" do |sign_in|
        r.params[:session] = session
        sign_in.call(r.params) do |m|
          m.success do
            r.redirect "/"
          end

          m.failure do |error|
            r.view "sign_in", error: error
          end
        end
      end
    end
  end
end