class UsersController < ApplicationController

def index
# binding.pry
@users = User.all
@book = Book.new  # books#indexで、新規投稿画面を表示(部分テンプレート用)
end
  
def show
@user = User.find(params[:id])
@book = Book.new  # users#showで、新規投稿画面を表示(部分テンプレート用)
end
  
def edit
@user = User.find(params[:id])
end

 def update
 # binding.pry
 @user = User.find(params[:id])
 if @user.update(user_params)
 flash[:notice] ="You have updated user successfully."
 redirect_to user_path(@user)
 else
 render action: :show
 end
 end

private

def user_params
params.require(:user).permit(:name, :introduction, :profile_image)
end

end
