class ChangeRatingDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :restaurants, :rating, 0
  end
end
