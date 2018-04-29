class DryTwitter::Web
  route "post" do |r|
    unless session[:user_name].nil?
      r.view "post"
    else
      r.redirect "sign_in"
    end
  end
end
