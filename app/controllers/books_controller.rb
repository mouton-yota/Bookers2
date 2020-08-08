class BooksController < ApplicationController
  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book)
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
      # @book = Book.find(params[:id])
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "本当に消しますか？"
    redirect_to books_path
  end

  private

  def ensure_correct_user
      @user = User.find_by(id: params[:id])
      if @user != current_usera
        redirect_to current_user
      end
    end

   def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
