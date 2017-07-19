# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(Faker::TwinPeaks.character, email: "bill@bill.bill", password: 'password')
end

# name: Faker::Beer.name
# style: Faker::Beer.style
# ibu: Faker::Beer.ibu.gsub(" IBU", "")
# abv: Faker::Beer.alcohol.gsub("%", "")
# srm: Faker::Beer.blg.gsub("°Blg", "")

# 3 times do for each type of ingredient (pre-select the type)
# Faker::Beer.hop
# Faker::Beer.yeast
# Faker::Beer.malts
# water: Faker::TwinPeaks.location

# origin: Faker::Address.country
