class Restaurant < ApplicationRecord

  validates_presence_of :name, :address, :rating, :cuisine, :accepts_10bis, :max_delivery_time

  has_many :reviews, dependent: :destroy

  def update_rating
    unless reviews.empty?
      self.rating = reviews.average(:rating)
      save!
    end
  end

end