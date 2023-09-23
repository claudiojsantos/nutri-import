FactoryBot.define do
  factory :product do
    code { Faker::Number.unique.number(digits: 10) }
    status { %w[active inactive archived].sample }
    imported_t { (Faker::Date.backward(days: 90) + 1.hours).to_datetime }
    url { Faker::Internet.url }
    creator { Faker::Name.name }
    created_t { imported_t }
    last_modified_t { imported_t - Faker::Number.between(from: 1, to: 30).days }
    product_name { Faker::Food.dish }
    quantity { Faker::Measurement.volume }
    brands { Faker::Company.name }
    categories { Faker::Commerce.department }
    labels { %w[eco bio new].sample }
    cities { Faker::Address.city }
    purchase_places { Faker::Address.street_name }
    stores { Faker::Company.name }
    ingredients_text { Faker::Food.ingredient }
    traces { Faker::Food.spice }
    serving_size { Faker::Measurement.volume }
    serving_quantity { Faker::Number.decimal(l_digits: 2) }
    nutriscore_score { Faker::Number.between(from: 0, to: 100) }
    nutriscore_grade { %w[A B C D E].sample }
    main_category { Faker::Commerce.department }
    image_url { Faker::Internet.url(host: 'example.com', path: '/someimage.jpg') }
  end
end
