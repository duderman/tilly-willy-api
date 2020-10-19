# frozen_string_literal: true

class AddDiscountIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :discounts, :type
    add_index :discounts, "(configuration->>'product_id')",
              using: :btree, name: 'index_discounts_on_product_id'
  end
end
