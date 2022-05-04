class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_user = @user.following_user
    @folloewer_user = @user.folloewr_user
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    # end追加
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end