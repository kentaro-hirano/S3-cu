class TravelsController < ApplicationController

  def index
    @travels = Travel.search(params[:search])
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
    @travel_comment = TravelComment.new
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
  
    #Viewのformで取得したパラメータをモデルに渡す

  def destroy
    @travel = Travel.find(params[:id])
    @travel.destroy
    redirect_to travels_path
  end

  def destroy_all
    @travel= current_user.travels
    @travel.destroy_all
    flash[:success] = "すべて削除しました"
    redirect_to user_path(current_user)
  end

  private
  def travel_params
    params.require(:travel).permit(:title, :body)
  end
end
