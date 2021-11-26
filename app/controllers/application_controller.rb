class ApplicationController < ActionController::API
  def authentication_failure
    render json: {message: "Couldn't authenticate your login."}, status: :unauthorized
  end
end
