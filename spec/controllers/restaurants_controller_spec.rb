require 'rails_helper'


describe RestaurantsController, type: :controller do
  render_views

  let(:restaurant) { FactoryGirl.create(:restaurant) }

  describe "GET" do
    it "renders the index view" do
      get :index
      expect(response).to render_template("index")
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template(:new)
    end

    it "renders the edit view" do
      get :edit, params: {id: restaurant.id}
      expect(response).to render_template(:edit)
    end

    it "renders the show view" do
      get :show, params: {id: restaurant.id}
      expect(response).to render_template(:show)
    end
  end

  describe "POST create" do
    it "should create new restaurant" do
      expect{
        post :create, params: { restaurant: FactoryGirl.attributes_for(:restaurant) }
      }.to change(Restaurant, :count).by(1)
    end
  end

end