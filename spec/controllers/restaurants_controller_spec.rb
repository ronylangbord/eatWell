require 'rails_helper'

describe RestaurantsController, type: :controller do
  render_views

  let(:restaurant) { FactoryGirl.create(:restaurant) }


  describe "GET" do
    it "should render the index view" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should render the new view" do
      get :new
      expect(response).to render_template(:new)
    end

    it "should render the edit view" do
      get :edit, params: {id: restaurant.id}
      expect(response).to render_template(:edit)
    end

    it "should render the show view" do
      get :show, params: {id: restaurant.id}
      expect(response).to render_template(:show)
    end
  end

  describe "POST create" do
    it "should create new restaurant and verify on db" do
      rest_params = FactoryGirl.attributes_for(:restaurant)
      expect{
        post :create, params: { restaurant: rest_params }
      }.to change(Restaurant, :count).by(1)
    end

    it "should succeed with correct data" do
       data = new_restaurant_data
       post :create, params: { restaurant: data }

      expect(response).to have_http_status(302)

    end
  end

  def new_restaurant_data
    restaurant_data(build(:restaurant))
  end

  def restaurant_data(res)
     res.as_json.symbolize_keys.slice(:name, :cuisine, :rating, :address, :max_delivery_time, :accepts_10bis)
  end

end