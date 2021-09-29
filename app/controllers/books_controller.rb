class BooksController < ApplicationController
  before_action :authenticate_user!
  impressionist :actions=>[:show]

  def index
    if params[:search]   
      @books = Book.search(params[:search])
    elsif params[:sort] == "latest"
      @books = Book.all.order(created_at: "DESC")
    elsif params[:sort] == "evaluate"
      @books = Book.all.order(evaluation: "DESC")
    else
      @books = Book.left_joins(:favorites).group(:id).order("count(favorites.book_id) DESC")
    end
    
    @book = Book.new
    @today_posts = Book.created_today.count # 今日投稿されたBook
    @yestarday_posts = Book.created_yesterday.count # 昨日投稿されたBook
    @previous_day_ratio = Book.rate_calculation(@today_posts, @yestarday_posts) # 前日比
    @this_week_posts = Book.created_this_week.count # 今週投稿されたBook
    @last_week_posts = Book.created_last_week.count # 先週投稿されたBook
    @previous_last_week_ratio = Book.rate_calculation(@this_week_posts, @last_week_posts) # 前週比
    
    @daily_counts = [] # 各曜日の投稿数を取得
    (1..7).reverse_each do |i|
      @daily_counts.push(Book.where(created_at: i.day.ago.all_day).count)
    end   

    gon.data = [] # 折れ線グラフの値を格納
    gon.data = @daily_counts
    gon.data.delete_at(0)
    gon.data.push(@today_posts)
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
      render :edit
    end
  end

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
    params.require(:book).permit(:title, :body, :image, :evaluation)
  end
end
