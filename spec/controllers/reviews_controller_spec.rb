require 'rails_helper'


describe ReviewsController, type: :controller do

  let(:restaurant) { FactoryGirl.create(:restaurant) }
  let(:review) { FactoryGirl.create(:review)}

  describe "GET" do
    it "should render the index view" do
        get :index, params: {restaurant_id: restaurant.id, id: review.id}
        expect(response).to render_template("index")
    end

    it "should render the new view" do
      get :new, params: {restaurant_id: restaurant.id}
      expect(response).to render_template("new")
    end

    it "should render the show view" do
      attach_review_to_restaurant(restaurant, review)
      get :show, params: {restaurant_id: restaurant.id, id: review.id}
      expect(response).to render_template("show")
    end

    it "should render the edit view" do
      attach_review_to_restaurant(restaurant, review)
      get :edit, params: {restaurant_id: restaurant.id, id: review.id}
      expect(response).to render_template("edit")
    end
  end

  describe "PUT update" do
    it "should update the review's name" do
      attach_review_to_restaurant(restaurant, review)
      attr = { name: 'Abcd' }
      put :update, params: {restaurant_id: restaurant.id, id: review.id, review: attr}
      expect(review.reload.name).to eql('Abcd')
    end

    it "should update the review's rating" do
      attach_review_to_restaurant(restaurant, review)
      attr = { rating: 2 }
      put :update, params: {restaurant_id: restaurant.id, id: review.id, review: attr}
      expect(review.reload.rating).to eq(2)
    end

    it "should update the review's comment" do
      attach_review_to_restaurant(restaurant, review)
      attr = { comment: 'Hello from update' }
      put :update, params: {restaurant_id: restaurant.id, id: review.id, review: attr}
      expect(review.reload.comment).to eq("Hello from update")
    end
  end


  describe "POST create" do
    it "should create correctly review's name" do
      review_local = FactoryGirl.build(:review, name: 'Elad')
      attach_review_to_restaurant(restaurant, review)
      post :create, params: {restaurant_id: restaurant.id, id: review.id, review: review_local}
      expect(review.name).to eq('Elad')
    end

    it "should update the review's rating" do
      attach_review_to_restaurant(restaurant, review)
      attr = { rating: 2 }
      put :update, params: {restaurant_id: restaurant.id, id: review.id, review: attr}
      expect(review.reload.rating).to eq(2)
    end

    it "should update the review's comment" do
      attach_review_to_restaurant(restaurant, review)
      attr = { comment: 'Hello from update' }
      put :update, params: {restaurant_id: restaurant.id, id: review.id, review: attr}
      expect(review.reload.comment).to eq("Hello from update")
    end
  end
  describe "POST" do
    it "should create new review" do
      expect{
        post :create, params: {restaurant_id: restaurant.id, review: FactoryGirl.attributes_for(:review)}
      }.to change(Review, :count).by(1)
    end
  end

  describe "DELETE" do
    it "should delete review" do
      attach_review_to_restaurant(restaurant, review)
      expect{
        delete :destroy, params: { id: review.id, restaurant_id: restaurant.id }
      }.to change(Review, :count).by(-1)
    end
  end

  def attach_review_to_restaurant(restaurant, review)
    restaurant.reviews<<review
  end
end