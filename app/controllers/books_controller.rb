class BooksController < ApplicationController
  before_action :authenticate_user!
  impressionist :actions=>[:show]

  def index
    if params[:search]   
      @books = Book.search(params[:search])
    else
      @books = Book.left_joins(:favorites).group(:id).order("count(favorites.book_id) DESC")
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "投稿に成功しました"
      redirect_to books_path
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    impressionist(@book, nil, unique: [:session_hash.to_s]) # session_hashは文字列型のためto_sを使って型変換
    @page_views = @book.impressionist_count
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      # binding.pry
      render :edit
    end
  end

    #Viewのformで取得したパラメータをモデルに渡すC

  def destroy
    @book = book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def destroy_all
    @book= current_user.books
    @book.destroy_all
    flash[:success] = "すべて削除しました"
    redirect_to user_path(current_user)
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
