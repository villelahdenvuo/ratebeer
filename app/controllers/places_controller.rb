class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
  	city = Rails.cache.read params[:from_search]

  	if city.nil?
      # TODO: load from beermapping api.
  		redirect_to places_path, notice: "Something went wrong."
  		return
  	end

  	@bar = city[city.find_index{|c| c.id == params[:id].to_s}]
  end
end