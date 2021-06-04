class BooksController < ApplicationController
before_action :ensure_current_user, {only: [:edit, :update]}

    def create  # 新規投稿フォーム保存（部分テンプレート）
    @book = Book.new(book_params) # 投稿フォームの入力値を受け取る
    @book.user_id = current_user.id  # create(投稿)したユーザーid = ログインしているユーザーid
    # binding.pry
    if @book.save   # 保存ができた場合は、
    flash[:success] ="You have created book successfully."
    redirect_to book_path(@book) # books#showへ
    else  
     # books#indexにレンダーさせるためにbooks#indexの定義をここに記入
    @books = Book.all
    @user = current_user
    # ----------------------------
    render :index
    end
    end

    def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    end

    def index  # 全ユーザー投稿一覧画面 # (user_books) # (/users/:user_id/books)
    @books = Book.all
    @book= Book.new  # books#indexで、新規投稿画面を表示(部分テンプレート用)
    @user = current_user
    end

# ログイン者とユーザー一致のときのみ編集ページにアクセス可
   def ensure_current_user
   @book = Book.find(params[:id])
   if current_user.id != @book.user.id  # @book.user.id {「投稿した本」に対応する「投稿したユーザー」の「id」（投稿されている本と、その投稿をしたユーザーをひもづける) と、 current_user.id (今ログインしている人の「id」)が一致していなければ}
    flash[:notice]="権限がありません"
    redirect_to books_path
   end
   end

    def edit  # 投稿編集画面 # (edit_user_book) # ( /users/:user_id/books/:id/edit)
    @book = Book.find(params[:id])
    end

    def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:success] ="You have updated book successfully."
    redirect_to book_path(@book.id) # 投稿詳細画面(books/show)
    else
    render :edit
    end
    end

    def destroy  # 投稿の削除
    @book = Book.find(params[:id])
    @book.destroy
    # binding.pry
    redirect_to books_path
    end

    private
    def book_params
     params.require(:book).permit(:title, :body)
    end
end
