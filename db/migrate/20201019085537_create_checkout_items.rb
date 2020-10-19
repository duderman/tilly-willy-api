# frozen_string_literal: true

class CreateCheckoutItems < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_items, id: :uuid do |t|
      t.references :checkout, type: :uuid, null: false, foreign_key: true, index: true
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.references :discount, type: :uuid, foreign_key: true
      t.monetize :price, amount: { default: nil }

      t.timestamps
    end
  end
end
