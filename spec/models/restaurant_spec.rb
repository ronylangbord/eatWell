require 'rails_helper'

describe Restaurant, type: :model do

  let(:restaurant) { FactoryGirl.create(:restaurant, cuisine: :American )}

  describe "data validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:cuisine) }
    it { should validate_presence_of(:max_delivery_time) }
    it { should validate_presence_of(:accepts_10bis) }
  end

  describe :cuisine do
    it 'should have a list of cuisines' do
      expect(Restaurant::CUISINES).to_not be_empty
    end
  end

  describe "Rating checks" do
    it "the default rating should be zero" do
      expect(restaurant.rating).to eq(0)
    end

    it "calc rating of restaurant when first review is added" do
      review = FactoryGirl.create(:review, rating: 3)
       attach_review_to_restaurant(restaurant, review)
       restaurant.update_rating
       expect(restaurant.reload.rating).to eq(3)
    end

    it "calc rating of restaurant who has couple of reviews" do
      review_1 = FactoryGirl.create(:review, rating: 3)
       attach_review_to_restaurant(restaurant, review_1)

      review_2 = FactoryGirl.create(:review, rating: 1)
       attach_review_to_restaurant(restaurant, review_2)
       restaurant.update_rating
       expect(restaurant.rating).to eq(2)
    end
  end

  def attach_review_to_restaurant(restaurant, review)
    restaurant.reviews<<review
  end
end
