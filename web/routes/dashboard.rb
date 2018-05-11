class DryTwitter::Web
  route "dashboard" do |r|
    r.authorize do
      r.resolve "posts.posts" do |posts|
        posts.call(session[:user_id]) do |m|
          m.success do |value|
            r.view "dashboard", posts: value
          end

          m.failure do |errors|
            r.view "dashboard", errors: errors
          end
        end
      end
    end
  end
end
