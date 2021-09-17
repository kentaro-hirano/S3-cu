class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @book = Book.new
  end

  def following
    @user = User.find(params[:id])
    @follow_users = @user.following_user
  end

  def follower
    @user = User.find(params[:id])
    @follower_users = @user.follower_user
  end
  def show
    @user = User.find(params[:id])
    @user_books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

    private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
