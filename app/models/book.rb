class Book < ApplicationRecord
 validates :title, presence: true
 validates :body, presence: true
 
 belongs_to :user
 has_many :book_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 
 attachment :image
 is_impressionable
 
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
 
 def self.search(search)
  if search
    Book.where(['title LIKE ?', "%#{search}%"])
  else
    Book.all
  end
 end
 
 def self.looks(searches, words)
    if searches == "perfect_match"
      @book = Book.where("title LIKE ?", "#{words}")
    else
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
 end

 # 今日投稿されたBookを取得
 scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
 # 昨日投稿されたBookを取得
 scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
 # 今週投稿されたBookの取得
 scope :created_this_week, -> { where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) }
 # 先週投稿されたBookの取得
 scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

 # 比率計算メソッド
 def self.rate_calculation(target_date, before_its_date)
  if before_its_date == 0
    return 0
  else
    return (target_date / before_its_date.to_f * 100).floor
  end
 end

end
