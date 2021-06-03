class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
      # if current_user
      #   flash[:notice] = "ログインに成功しました" 
      # else
      #   flash[:notice] = "新規登録完了しました。" 
      # end
  end
  
    def after_sign_up_path_for(resource)
    user_path(current_user.id)
      # if current_user
      #   flash[:notice] = "ログインに成功しました" 
      # else
      #   flash[:notice] = "新規登録完了しました。" 
      # end
  end
  
  
  
  # def after_users_sign_up_path_for(resource)
  #   user_path(current_user.id)
  
  # end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:edit_user, keys: [:introduction])
    devise_parameter_sanitizer.permit(:edit_user, keys: [:profile_image_id])
  end
end
