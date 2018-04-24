class DryTwitter::Web
  route "post" do |r|
    r.get do
      unless session[:user_name].nil?
        r.view "post"
      else
        r.redirect "sign_in"
      end
    end

    r.post do
      r.resolve "post.post" do |post|
        post.call(r.params) do |m|
          m.success do
            r.redirect "/"
          end

          m.failure do |errors|
            params_and_errors = r.params.merge({})
            params_and_errors[:errors] = errors
            r.view "post", input: params_and_errors
          end
        end
      end
    end
  end
end
