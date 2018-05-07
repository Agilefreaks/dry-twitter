class DryTwitter::Web
  route "post" do |r|
    r.authorize do
      r.get do
        r.view "post"
      end

      r.post do
        r.resolve "post.post" do |post|
          r.params[:session] = session
          post.call(r.params) do |m|
            m.success do
              r.redirect "/dashboard"
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
end
