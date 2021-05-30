class BooksController < ApplicationController



    def create  # 新規投稿フォーム保存（部分テンプレート）
    @book = Book.new(book_params) # 投稿フォームの入力値を受け取る
    @book.user_id = current_user.id  # 投稿者がログインしている場合は
    # binding.pry
    if @book.save   # 保存ができた場合は、
    flash[:notice] ="You have created book successfully."
    redirect_to book_path(@book)
    else
    render :show  # 保存できなければ、再び新規投稿画面を表示
    end
    end

    def show
    @book = Book.find(params[:id])
    end  
   
    def index  # 全ユーザー投稿一覧画面 # (user_books) # (/users/:user_id/books)
    @books = Book.all
    @book = Book.new  # books#indexで、新規投稿画面を表示(部分テンプレート用)
    end

    def edit  # 投稿編集画面 # (edit_user_book) # ( /users/:user_id/books/:id/edit)
    @book = Book.find(params[:id])
    end

    def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id) # 投稿詳細画面(books/show)
    end

    def destroy  # 投稿の削除
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    end

    private
    def book_params
     params.require(:book).permit(:title, :body)
    end
end
