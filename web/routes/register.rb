class DryTwitter::Web
  route "register" do |r|
    r.get do
      r.view "register"
    end

    r.post do
      r.params
      r.view "register"
    end
  end
end
