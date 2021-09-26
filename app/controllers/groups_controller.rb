class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    @group.save
    redirect_to groups_path
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
    @members = @group.users
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to group_path(@group)
  end

  def edit
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.destroy(current_user)
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
