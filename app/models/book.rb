class Book < ApplicationRecord
 validates :title, presence: true
 validates :body, presence: true
 
 belongs_to :user
 has_many :book_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 
 attachment :image
 
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
end
