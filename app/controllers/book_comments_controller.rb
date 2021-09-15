class BookCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    comment.save
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    comment = BookComment.find_by(book_id: @book.id)
    comment.destroy
  end
  
  private
  def travel_comment_params
    params.require(:travel_comment).permit(:comment)
  end
end
