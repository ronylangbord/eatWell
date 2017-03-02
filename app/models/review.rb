class Review < ApplicationRecord

  belongs_to :restaurant

  validates_presence_of :name, :comment, :rating

  after_create :calc_rating
  after_update :calc_rating
  after_destroy :calc_rating

  private

  def calc_rating
    restaurant.update_rating
  end
end
