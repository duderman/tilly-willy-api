# frozen_string_literal: true

class Checkout < ApplicationRecord
  has_many :items, class_name: 'CheckoutItem', dependent: :delete_all
end
