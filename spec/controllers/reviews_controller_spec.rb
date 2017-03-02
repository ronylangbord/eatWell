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
    it "should update a certain review" do
      attach_review_to_restaurant(restaurant, review)
      attr = { name: 'Abcd', rating: 2, comment: 'Hello from update'}
      put :update, params: {restaurant_id: restaurant.id, id: review.id, review: attr}
      expect(review.reload.name).to eq('Abcd')
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