# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {name: Faker::TwinPeaks.character, email: "bill@bill.bill", password: 'password'},
  {name: Faker::TwinPeaks.character, email: "ted@ted.ted", password: 'password'}
  ])

User.all.each do |user|
  5.times { Beer.create([
    name: Faker::Beer.name,
    user_id: user.id,
    style: Faker::Beer.style,
    ibu: Faker::Beer.ibu.gsub(" IBU", ""),
    abv: Faker::Beer.alcohol.gsub("%", ""),
    srm: Faker::Beer.blg.gsub("°Blg", "")
  ]) }
end
#

5.times do
  Ingredient.create(
  name: Faker::Beer.hop,
  kind: "Hops",
  origin: Faker::Address.country
  )
end
5.times do
  Ingredient.create(
  name: Faker::Beer.malts,
  kind: "Grain",
  origin: Faker::Address.country
  )
end
5.times do
  Ingredient.create(
  name: Faker::Beer.yeast,
  kind: "Yeast",
  origin: Faker::Address.country
  )
end
5.times do
  Ingredient.create(
  name: Faker::TwinPeaks.location,
  kind: "Water",
  origin: Faker::Address.country
  )
end
#Beer.all.each do |beer|
# {Ingredient.create , beer.id}

counter = 1
Ingredient.all.each do |ingredient|
  BeerIngredient.create(
  ingredient_id: ingredient.id,
  beer_id: counter,
  amount: Faker::Number.between(1, 10)
  )
  BeerIngredient.create(
  ingredient_id: ingredient.id,
  beer_id: counter + 5,
  amount: Faker::Number.between(1, 10)
  )
  if counter < 5
    counter += 1
  else
    counter = 1
  end

end
