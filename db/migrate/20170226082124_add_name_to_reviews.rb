class AddNameToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :name, :string
  end
end
