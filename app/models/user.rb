class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :travels, dependent: :destroy
  has_many :travel_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :profile_image
  
  def self.looks(searches, words)
    if searches == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end

end
