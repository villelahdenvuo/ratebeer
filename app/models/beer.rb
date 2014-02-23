class Beer < ActiveRecord::Base
	include RatingAverage

	belongs_to :brewery
	belongs_to :style
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user

	validates :name, presence: true
	validates :style_id, presence: true

  def self.top(n)
    Beer.all.sort_by{ |b| -(b.average_rating || 0) }[0..n-1]
  end

	def to_s
		"#{name} - #{brewery.name}"
	end
end
