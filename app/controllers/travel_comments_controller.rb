class TravelCommentsController < ApplicationController
  
  def create
    travel = Travel.find(params[:travel_id])
    comment = TravelComment.new(travel_comment_params)
    comment.user_id = current_user.id
    comment.travel_id = travel.id
    comment.save
    redirect_to travel_path(travel)
  end
  
  def destroy
    comment = TravelComment.find_by(travel_id: params[:travel_id])
    comment.destroy
    redirect_to travel_path(params[:travel_id])
  end
  
  private
  def travel_comment_params
    params.require(:travel_comment).permit(:comment)
  end
end
