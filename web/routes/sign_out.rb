class DryTwitter::Web
  route "sign_out" do |r|
    session[:user_id] = session[:user_name] = nil
    r.redirect "/"
  end
end
