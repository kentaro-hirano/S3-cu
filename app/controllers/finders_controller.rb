class FindersController < ApplicationController
  def finder
    @travel = Book.new
    @range = params[:range]
  
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @travels = Book.looks(params[:search], params[:word])
    end
  end
end
