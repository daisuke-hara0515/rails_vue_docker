class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        include Firebase::Auth::Authenticable
        before_action :authenticate_user
end
