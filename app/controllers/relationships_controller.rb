class RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id])
    flash[:success] = "フォローしました"
    redirect_back(fallback_location: root_path)
  end
  
  def unfollow
    current_user.unfollow(params[:id])
    flash[:alert] = "フォローを解除しました"
    redirect_back(fallback_location: root_path)
  end
end
