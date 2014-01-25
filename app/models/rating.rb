class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
  	"#{beer.name} got rated a #{score}"
  end
end