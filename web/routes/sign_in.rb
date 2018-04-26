class DryTwitter::Web
  route "sign_in" do |r|
    r.get do
      r.view "sign_in"
    end

    r.post do
      r.resolve "sign_in.sign_in" do |sign_in|
        sign_in.call(r.params) do |m|
          m.success do
            r.redirect "/"
          end

          m.failure :validate do |errors|
            params_and_errors = r.params.merge({})
            params_and_errors[:errors] = errors
            r.view "sign_in", input: params_and_errors
          end

          m.failure do |errors|
            p errors
          end
        end
      end
    end
  end
end