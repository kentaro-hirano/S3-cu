class CreateTravelComments < ActiveRecord::Migration[5.2]
  def change
    create_table :travel_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :travel_id

      t.timestamps
    end
  end
end
