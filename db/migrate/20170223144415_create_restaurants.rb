class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :cuisine
      t.integer :rating
      t.string :address
      t.integer :max_delivery_time
      t.boolean :accepts_10bis

      t.timestamps
    end
  end
end
