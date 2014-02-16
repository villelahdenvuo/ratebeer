# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

lager = Style.find_by name:"Lager"
ale = Style.find_by name:"Pale ale"
porter = Style.find_by name:"Porter"
weizen = Style.find_by name:"Weizen"

b1.beers.create name:"Iso 3", style:lager
b1.beers.create name:"Karhu", style:lager
b1.beers.create name:"Tuplahumala", style:lager
b2.beers.create name:"Huvila Pale Ale", style:ale
b2.beers.create name:"X Porter", style:porter
b3.beers.create name:"Hefezeizen", style:weizen
b3.beers.create name:"Helles", style: lager