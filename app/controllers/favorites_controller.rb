class FavoritesController < ApplicationController

  def create
    travel = Travel.find(params[:travel_id])
    favorite = current_user.favorites.new(travel_id: travel.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    favorite = Favorite.find_by(travel_id: params[:travel_id])
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
