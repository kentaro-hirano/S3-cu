class TravelCommentsController < ApplicationController
  
  def create
    @travel = Travel.find(params[:travel_id])
    comment = TravelComment.new(travel_comment_params)
    comment.user_id = current_user.id
    comment.travel_id = @travel.id
    comment.save
  end
  
  def destroy
    @travel = Travel.find(params[:travel_id])
    comment = TravelComment.find_by(travel_id: @travel.id)
    comment.destroy
  end
  
  private
  def travel_comment_params
    params.require(:travel_comment).permit(:comment)
  end
end
