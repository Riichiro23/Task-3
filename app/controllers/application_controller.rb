class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
      # if current_user
      #   flash[:notice] = "ログインに成功しました" 
      # else
      #   flash[:notice] = "新規登録完了しました。次に名前を入力してください" 
      #   rootrails _path  #　指定したいパスに変更
      # end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:edit_user, keys: [:introduction])
    devise_parameter_sanitizer.permit(:edit_user, keys: [:profile_image_id])
  end
end
