class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def private_route
    unless current_user
      redirect_to new_user_session_path, :notice => 'you need to sign in to access this content'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
        :first_name,
        :last_name,
        :username,
        :email,
        :password
      )
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(
        :first_name,
        :last_name,
        :username,
        :email,
        :password,
        :current_password
      )
    end
  end
end
