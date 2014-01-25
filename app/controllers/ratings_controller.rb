class RatingsController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  def index
  	@ratings = Rating.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end  
end