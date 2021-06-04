class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger    # Flashメッセージの装飾用(bootstrap)
  before_action :authenticate_user!,except: [:top, :about]  # home about 画面以外は、ログインしていない人がアクセスできないように制限
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

# def create
#     user = User.find_by(name: params[:name].downcase)
#     if user && user.authenticate(params[:password])
#       log_in user
#       flash[:notice] = "サインアップに成功しました。"
#       redirect_to user_path(current_user.id)
#     end
# end

# signed out のFlashメッセージ
def destroy
    session.delete(:user_id)
    @current_user = nil
    flash[:alert] = "ログアウトしました"
    redirect_to :root
end

# def after_sign_out_path_for(resource)
#     　root_path
#     #   if current_user
#     #      flash[:success] = "ログアウトに成功しました" 
#     #   end
# end



protected

def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])  # デフォルトでは、sign_in の認証を[:email]でできるようにしていたが、下記で[:name]に変更してしまい、[:email]はただの空のカラムになってしまったので、ここで再定義する必要がある。[:email]を再定義すれば、[:name]は必要なくなるので書かなくても良い
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])   # config/initializers/devise.rbにて、 config.authentication_keys = [:email] (デフォルト)をconfig.authentication_keys = [:name]に変更 = ログインを[:name]の値でできるようにした。
    devise_parameter_sanitizer.permit(:edit_user, keys: [:introduction])
    devise_parameter_sanitizer.permit(:edit_user, keys: [:profile_image_id])
end
  
end











