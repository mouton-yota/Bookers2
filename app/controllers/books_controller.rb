class BooksController < ApplicationController
before_action :authenticate_user!
before_action :ensure_correct_book, only: [:edit]

  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
    
     if @book.save
     	flash[:notice] = "You have creatad book successfully."
        redirect_to book_path(@book)
     else
     	@users = User.all
  	    @books = Book.all
  	    render 'index'
  	 end
  end

  def index
    @users = User.all
  	@books = Book.all
  	@book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
  	@book_new = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	 @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "本当に消しますか？"
    redirect_to books_path
  end

  def ensure_correct_book
      book = Book.find(params[:id])
      if book.user_id != current_user.id
        redirect_to books_path
      end
  end


  private


   def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
