class Travel < ApplicationRecord
 validates :title, presence: true
 validates :body, presence: true
 
 belongs_to :user
 
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
