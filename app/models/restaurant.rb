class Restaurant < ApplicationRecord

  validates_presence_of :name, :address, :rating, :cuisine, :accepts_10bis, :max_delivery_time

  has_many :reviews, dependent: :destroy

  ALL_CUISINES = [
      :American,
      :Italian,
      :Asian,
      :Japanese,
      :Chinese,
      :Israeli,
      :Mexican,
      :Thai,
      :Vegetarian
  ]

  enumify :cuisine, ALL_CUISINES

  def update_rating
    unless reviews.empty?
      self.rating = reviews.average(:rating)
      save!
    end
  end

end