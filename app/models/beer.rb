class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating
		ratings.inject(0) { |sum, el| sum + el.score } / ratings.size
	end

	def to_s
		"#{name} - #{brewery.name}"
	end
end
