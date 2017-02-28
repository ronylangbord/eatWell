class Review < ApplicationRecord

  belongs_to :restaurant

  validates :name, :presence => true
  validates :rating, :presence => true
  validates :comment, :presence => true

  after_create :calc_rating
  after_update :calc_rating

  def calc_rating
    restaurant.update_rating
  end
end
