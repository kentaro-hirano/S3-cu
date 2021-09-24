class FindersController < ApplicationController
  def finder
    @book = Book.new
    @range = params[:range]
  
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end

    if params[:date_form] 
      date = params[:date_form].to_date
      @posts_count = Book.where(created_at: date.all_day).count
      respond_to do |format|
        format.js { render 'finder.js.erb' } 
      end
    end  
    
  end
end
