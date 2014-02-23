module RatingAverage
	extend ActiveSupport::Concern
	
	def average_rating
		if ratings.empty?
			return 0
		else
			ratings.inject(0) { |sum, el| sum + el.score } / ratings.size
		end
	end
end