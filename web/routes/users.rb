class DryTwitter::Web
  route "users" do |r|
    unless session[:user_name].nil?
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
    else
      r.redirect "sign_in"
    end
  end
end
