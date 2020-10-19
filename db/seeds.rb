# frozen_string_literal: true

heart = Product.find_or_initialize_by(code: 1).tap { _1.update!(name: 'Lavender heart', price: 9.25) }
Product.find_or_initialize_by(code: 2).update!(name: 'Personalised cufflinks', price: 45.00)
Product.find_or_initialize_by(code: 3).update!(name: 'Kids T-shirt', price: 19.95)

heart_discount_params = { product_id: heart.id, quantity: 2 }

unless Discount::Quantity.where(['configuration @> :params', { params: heart_discount_params.to_json }]).exists?
  Discount::Quantity.create!(heart_discount_params.merge(price: 8.50))
end

unless Discount::Total.where(percentage: 10).where(['configuration @> :params', { params: { sum_cents: 6_000 }.to_json }]).exists? # rubocop:disable Layout/LineLength
  Discount::Total.create!(percentage: 10, sum_cents: 6_000)
end
