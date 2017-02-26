class AddRestaurantsToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :restaurants, foreign_key: true
  end
end
