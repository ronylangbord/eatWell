class Review < ApplicationRecord

  belongs_to :restaurant

  after_create :calc_rating

  private

  def calc_rating
    restaurant.update_rating
  end
end
