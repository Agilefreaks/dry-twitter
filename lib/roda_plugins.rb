require "roda"

class Roda
  module RodaPlugins
    module Auth
      module RequestMethods
        def authorize
          if scope.session[:user_id]
            yield
          else
            redirect "sign_in"
          end
        end
      end
    end

    register_plugin :auth, Auth
  end
end