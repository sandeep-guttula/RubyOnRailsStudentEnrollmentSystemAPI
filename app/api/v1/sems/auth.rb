require "authentication_helpers"
class Api::V1::Sems::Auth < Grape::API

  include AuthenticationHelpers

  resource :auth do
    # Login
    resource :login do
      desc "Login"
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post do

        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          payload = { user_id: user.id, exp: Time.now.to_i + 4 * 3600 }
          token = JWT.encode(payload, "my$ecretK3")
          if token
            present({ token: token, user: user }, with: V1::Entities::Login)
          end
        else
          error!({ error: "Invalid email or password" }, 400)
        end
      end
    end

  end
end
