class UsersController < ApplicationController
  before_action :correct_user, only: [:update]
  before_action :authenticate_user!

  def show
    @users=User.find(params[:id])
    @books=@users.books
    @book=Book.new
  end

  def edit
    @user=User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end 
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @books=@user.books
    # 　フラッシュ
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "error"
      render :edit
    end

    
  end


  def index
    @book = Book.new
    @user=User.all
    @users=current_user
  end
  

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)  
  end
  
  

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user

  end
  

end



