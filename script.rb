# days = Day.include(:daily_total)

# Day.all.each do |d|

# end

def my_rand(base, dec_places = 0)
  rand(0..base) + (rand(0..99)/100.00).round(dec_places)
end


Day.all.each do |day|
    DailyTotal.create(company_id: 1, day_id: day.id, count: 24470 + my_rand(100))
    SharePrice.create(company_id: 1, day_id: day.id, price: 80 + my_rand(5, 2))

    DailyTotal.create(company_id: 2, day_id: day.id, count: 2287 + my_rand(100))
    SharePrice.create(company_id: 2, day_id: day.id, price: 69 + my_rand(5, 2))

    DailyTotal.create(company_id: 3, day_id: day.id, count: 547 + my_rand(100))
    SharePrice.create(company_id: 3, day_id: day.id, price: 21 + my_rand(5, 2))

    DailyTotal.create(company_id: 4, day_id: day.id, count: 601 + my_rand(100))
    SharePrice.create(company_id: 4, day_id: day.id, price: 62 + my_rand(5, 2))

    DailyTotal.create(company_id: 5, day_id: day.id, count: 3009 + my_rand(100))
    SharePrice.create(company_id: 5, day_id: day.id, price: 149 + my_rand(5, 2))

    DailyTotal.create(company_id: 6, day_id: day.id, count: 226 + my_rand(100))
    SharePrice.create(company_id: 6, day_id: day.id, price: 47 + my_rand(5, 2))

    DailyTotal.create(company_id: 7, day_id: day.id, count: 680 + my_rand(100))
    SharePrice.create(company_id: 7, day_id: day.id, price: 76 + my_rand(5, 2))

    DailyTotal.create(company_id: 8, day_id: day.id, count: 2145 + my_rand(100))
    SharePrice.create(company_id: 8, day_id: day.id, price: 77 + my_rand(5, 2))

    DailyTotal.create(company_id: 9, day_id: day.id, count: 2570 + my_rand(100))
    SharePrice.create(company_id: 9, day_id: day.id, price: 51 + my_rand(5, 2))

    DailyTotal.create(company_id: 10, day_id: day.id, count: 2516 + my_rand(100))
    SharePrice.create(company_id: 10, day_id: day.id, price: 74 + my_rand(5, 2))

    DailyTotal.create(company_id: 11, day_id: day.id, count: 3058 + my_rand(100))
    SharePrice.create(company_id: 11, day_id: day.id, price: 115 + my_rand(5, 2))

    DailyTotal.create(company_id: 12, day_id: day.id, count: 723 + my_rand(100))
    SharePrice.create(company_id: 12, day_id: day.id, price: 9 + my_rand(5, 2))

    DailyTotal.create(company_id: 13, day_id: day.id, count: 37298 + my_rand(100))
    SharePrice.create(company_id: 13, day_id: day.id, price: 97 + my_rand(5, 2))    
end
