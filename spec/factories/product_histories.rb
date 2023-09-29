FactoryBot.define do
  factory :product_history do
    product_code { Faker::Barcode.unique.ean(13) }
    imported_t { Faker::Time.backward(days: 30) }
    status { %w[draft published].sample }
    import_sources { Faker::Internet.url }
    import_by { 'automated_script' }
    notes { 'Criação de produto' }
    product_data do
      {
        code: Faker::Barcode.unique.ean(13),
        url: Faker::Internet.url,
        creator: Faker::Internet.username,
        created_t: Faker::Number.number(digits: 10),
        last_modified_t: Faker::Number.number(digits: 10),
        product_name: Faker::Food.dish,
        quantity: "#{Faker::Number.number(digits: 3)} g",
        brands: Faker::Company.name,
        categories: Faker::Commerce.department,
        labels: Faker::Food.description,
        cities: Faker::Address.city,
        purchase_places: Faker::Address.city,
        stores: Faker::Company.name,
        ingredients_text: Faker::Food.ingredient,
        traces: Faker::Food.spice,
        serving_size: "#{Faker::Number.number(digits: 2)} g",
        serving_quantity: Faker::Number.decimal(l_digits: 2),
        nutriscore_score: Faker::Number.between(from: 0, to: 40),
        nutriscore_grade: %w[a b c d e].sample,
        main_category: Faker::Commerce.department,
        image_url: Faker::Internet.url,
        status: %w[draft published].sample,
        imported_t: Faker::Time.backward(days: 30)
      }
    end
  end
end
