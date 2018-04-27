class DryTwitter::Web
  route "dashboard" do |r|
    unless session[:user_name].nil?
      r.view "dashboard"
    else
      r.redirect "sign_in"
    end
  end
end
