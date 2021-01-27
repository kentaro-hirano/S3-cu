class TravelsController < ApplicationController

  def index
    @travels = Travel.all
    @travel = Travel.new
  end

  def create
    @travel = Travel.new(travel_params)
    @travel.user_id = current_user.id
    if @travel.save
      flash[:success] = "投稿に成功しました"
      redirect_to travels_path
    else
      @travels = Travel.all
      render 'index'
    end
  end

  def show
    @travel_new = Travel.new
    @travel = Travel.find(params[:id])
  end

  def edit
    @travel = Travel.find(params[:id])
  end

  def update
    @travel = Travel.find(params[:id])
    if @travel.update(travel_params)
      redirect_to travel_path(@travel)
    else
      render 'edit'
    end
  end

  def destroy
    @travel = Travel.find(params[:id])
    @travel.destroy
    redirect_to travels_path
  end

  private
  def travel_params
    params.require(:travel).permit(:title, :body)
  end
end
