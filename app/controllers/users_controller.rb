  class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
   @user = User.new
  end
  def create
    @user = User.new(user_params)
    @book.user_id = current_user.id
    if @user.save
      flash[:notice] = "successfully"
    redirect_to user_path(@user.id)
    else
      @users = User.all
      render :index
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
  end

  def edit

  @user = User.find(params[:id])
  end

  def index
  @user =  current_user
  @users = User.all
  @book = Book.new
  @books = Book.all
  end

  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render"edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_path(@user.id)
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)

  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  end


