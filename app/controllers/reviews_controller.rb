class ReviewsController < ApplicationController

  before_action :set_restaurant
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @reviews = Review.all
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)


    respond_to do |format|
      if @review.save
        calc_rating(@review)
        format.html { redirect_to restaurant_reviews_url, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to restaurant_review_url, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id]);
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @restaurant, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    end

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:name, :rating, :comment)
    end


  def calc_rating(curr_review)

    @restaurant = Restaurant.find(params[:restaurant_id])

    if Restaurant.find(params[:restaurant_id]).reviews.empty?
        @restaurant.rating = curr_review.rating
    else
      @restaurant.rating = @restaurant.reviews.average(:rating)
    end

    @restaurant.save
    end

end
