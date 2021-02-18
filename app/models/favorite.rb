class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :travel
  
  validates_uniqueness_of :travel_id, scope: :user_id
end

