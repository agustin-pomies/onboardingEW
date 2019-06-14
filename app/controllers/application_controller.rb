class ApplicationController < ActionController::Base
  # Overwrite the sign_in redirect path method
  def after_sign_in_path_for(resource)
    tasks_path
  end

  # Overwrite the sign_out redirect path method
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
