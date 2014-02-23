class Style < ActiveRecord::Base
	has_many :beers

  def self.top(n)
    Style.all.sort_by{ |s| -(s.average_rating || 0) }[0..n-1]
  end

  def average_rating
  	if beers.empty?
  		return 0
  	else 
  		beers.inject(0) { |sum, el| sum + el.average_rating } / beers.size
  	end
  end

  def to_s
  	"#{name}"
  end
end
