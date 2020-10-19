# frozen_string_literal: true

class Product < ApplicationRecord
  monetize :price_cents, numericality: { greater_than: 0 }

  validates :code, uniqueness: true, presence: true, numericality: { greater_than: 0 }
  validates :name, presence: true
end
