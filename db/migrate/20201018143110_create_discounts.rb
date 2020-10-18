# frozen_string_literal: true

class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts, id: :uuid do |t|
      t.string :type, null: false
      t.integer :percentage
      t.monetize :price, amount: { null: true, default: nil }
      t.jsonb :configuration, null: false, default: {}

      t.timestamps
    end
  end
end
