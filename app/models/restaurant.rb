class Restaurant < ApplicationRecord

  validates :name, :presence => true
  validates :address, :presence => true

  has_many :reviews, dependent: :destroy

  def update_rating
    unless reviews.empty?
      self.rating= reviews.average(:rating)
    end
    save!
  end

end