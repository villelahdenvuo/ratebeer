class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def average_rating
		ratings.inject(0) { |sum, el| sum + el.score } / ratings.size
	end
end
