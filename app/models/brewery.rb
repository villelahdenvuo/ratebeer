class Brewery < ActiveRecord::Base
	include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { less_than_or_equal_to: ->(_) { Time.now.year },
                                    only_integer: true }


  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def self.top(n)
    Brewery.all.sort_by{ |b| -(b.average_rating || 0) }[0..n-1]
  end

	def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    puts "number of ratings #{ratings.count}"
  end

  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

  def to_s
    "#{name} since #{year}"
  end
end
