class CustomFailure < Devise::FailureApp
  def redirect_url
    authentication_failure_url
  end

end