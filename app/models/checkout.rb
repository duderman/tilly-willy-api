class Checkout < ApplicationRecord
  has_many :items, class_name: 'CheckoutItem'
end
