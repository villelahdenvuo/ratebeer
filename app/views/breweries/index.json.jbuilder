json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.count brewery.beers.count
end
