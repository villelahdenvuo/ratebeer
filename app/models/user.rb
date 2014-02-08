class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships
	has_many :beer_clubs, through: :memberships

	validates :username, uniqueness: true,
							length: { minimum: 3, maximum: 15 }
		validates :password, length: { minimum: 4 },
							format: { with: /((?=.*\d)(?=.*[A-Z])).+/,
								message: "must containt a capital letter and a number."}

		def favorite_beer
			return nil if ratings.empty?
			ratings.order(score: :desc).limit(1).first.beer
		end

		def favorite_style
			return nil if ratings.empty?
			ratings
				.joins(:beer)
				.group(:style)
				.order(score: :desc)
				.limit(1)
				.first.beer.style
		end
end