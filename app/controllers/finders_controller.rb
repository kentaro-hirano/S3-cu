class FindersController < ApplicationController
  def finder
    @travel = Travel.new
    @range = params[:range]
  
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @travels = Travel.looks(params[:search], params[:word])
    end
  end
end
