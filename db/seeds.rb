# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Day.add(5)

Company.create!(name: "Walmart", symbol: "WMT")
Company.create!(name: "Macy's", symbol: "M")
Company.create!(name: "Abercrombie", symbol: "ANF")
Company.create!(name: "\"Foot Locker\"", symbol: "FL")
Company.create!(name: "Costco", symbol: "COST")
Company.create!(name: "\"Big Lots\"", symbol: "BIG")
Company.create!(name: "\"Dollar General\"", symbol: "DG")
Company.create!(name: "Safeway", symbol: "SWY")
Company.create!(name: "Kroger", symbol: "KR")
Company.create!(name: "\"Whole Foods\"", symbol: "WFM")
Company.create!(name: "Lowe's", symbol: "LOW")
Company.create!(name: "\"Home Depot\"", symbol: "HD")
Company.create!(name: "\"Office Depot\"", symbol: "ODP")
Company.create!(name: "\"Burger King\"", symbol: "BKW")
Company.create!(name: "McDonald's", symbol: "MCD")