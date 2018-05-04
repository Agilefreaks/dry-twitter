class DryTwitter::Web
  route "users" do |r|
    unless session[:user_name].nil?
      r.get do
        r.resolve "users.users" do |users|
          users.call(session[:user_id]) do |m|
            m.success do |value|
              r.view "users", users: value
            end

            m.failure do |errors|
              r.view "users", errors: errors
            end
          end
        end
      end

      r.post do
        r.resolve "users.follow_unfollow" do |folow_unfollow|
          folow_unfollow.call(user_id: session[:user_id], followed_user_id: r.params["user_id"]) do |m|
            m.success do |value|
              r.view "users", users: value
            end

            m.failure do |errors|
              r.view "users", errors: errors
            end
          end
        end
      end
    else
      r.redirect "sign_in"
    end
  end
end
