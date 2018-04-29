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
        r.params[:session] = session
        post.call(r.params) do |m|
          m.success do
            r.redirect "/"
          end

          m.failure do |errors|
            r.params[:errors] = errors
            r.view "post", input: r.params
          end
        end
      end
    end
  end
end
