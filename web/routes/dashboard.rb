class DryTwitter::Web
  route "dashboard" do |r|
    unless session[:user_name].nil?
      r.resolve "posts.posts" do |posts|
        posts.call(session[:user_id]) do |m|
          m.success do |value|
            r.view "dashboard", users: value
          end

          m.failure do |errors|
            r.view "dashboard", errors: errors
          end
        end
      end
    else
      r.redirect "sign_in"
    end
  end
end
