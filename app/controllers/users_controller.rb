class UsersController < ApplicationController

# 変数は、def〜end 内でアクションごとにそれぞれに定義する。
# アクション間で、変数は紐づいているわけではない。

def index
# binding.pry
@users = User.all
@book = Book.new  # books#indexで、新規投稿画面を表示(部分テンプレート用)
@user = current_user
end

def show
@user = User.find(params[:id])
@book = Book.new  # 部分テンプレート(新規投稿)
end

# ログイン者とユーザー一致のときのみ編集ページにアクセス可
before_action :ensure_current_user, {only: [:edit, :update]}
def ensure_current_user
  if current_user.id != params[:id].to_i
    flash[:notice]="権限がありません"
    redirect_to user_path(current_user.id)
  end
end

def edit
@user = User.find(params[:id])
end


def update
# binding.pry
@user = User.find(params[:id])
if @user.update(user_params)
flash[:success] ="You have updated user successfully."
redirect_to user_path(@user)
else
render :edit
end
end

private

def user_params
params.require(:user).permit(:name, :introduction, :profile_image)
end

end
