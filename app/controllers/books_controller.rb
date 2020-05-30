class BooksController < ApplicationController
    before_action :authenticate_user!

  def index
    @book = Book.new
    @user = current_user || User.find_by(id:session[:user_id])
    @books = Book.all
  end

  def show
    @book_d = Book.find(params[:id])
    @book = Book.new
    @user = @book_d.user
    @books = @user.books.all
    @post_comment = PostComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render action: :edit
    else
      redirect_to books_path
    end
  end

  def update
        @book = Book.find(params[:id])
    if @book.update(book_params)
     redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render :index
    end
  end

   private

  def book_params
      params.require(:book).permit(:title, :body)
  end





end
