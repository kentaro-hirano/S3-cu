class Travel < ApplicationRecord
 validates :title, presence: true
 validates :body, presence: true
 
 belongs_to :user
 has_many :travel_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 
 attachment :image
 
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
 
 def self.search(search)
  if search
    Travel.where(['title LIKE ?', "%#{search}%"])
  else
    Travel.all
  end
 end
 
 def self.looks(searches, words)
    if searches == "perfect_match"
      @travel = Travel.where("title LIKE ?", "#{words}")
    else
      @travel = Travel.where("title LIKE ?", "%#{words}%")
    end
 end
end
