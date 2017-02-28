class Restaurant < ApplicationRecord

  validates :name, :presence => true
  validates :address, :presence => true
  validates :rating, :presence => true
  validates :cuisine, :presence => true
  validates :accepts_10bis, :presence => true
  validates :max_delivery_time, :presence => true

  has_many :reviews, dependent: :destroy

  def update_rating
    unless reviews.empty?
      self.rating = reviews.average(:rating)
      save!
    end
  end

end