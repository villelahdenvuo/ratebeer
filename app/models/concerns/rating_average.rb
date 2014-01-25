module RatingAverage
	extend ActiveSupport::Concern
	
	def average_rating
		ratings.inject(0) { |sum, el| sum + el.score } / ratings.size
	end
end