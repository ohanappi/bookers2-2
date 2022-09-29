class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
    
  def new
  end
  
  def index
    @book = Book.new
    @books=Book.all
    @users=current_user
  end
  
  def show
    @book = Book.new
    @user=current_user
    @books=Book.find(params[:id])
    @users=@books.user
  end 
  
  def edit
    @book=Book.find(params[:id])
    
  end 
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    @book.save
    @users=current_user
    @books=Book.all

    # 　フラッシュ
    if Book.new(book_params)
      flash[:success] = "You have created book successfully."
    else
      flash.now[:danger] = "error"
      render :index
    end
    
    # バリテーション
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :index
    end 

  end

    
  
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)

    # 　フラッシュ
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      flash.now[:danger] = "error"
      render :edit
    end

  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
