# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products, id: :uuid do |t|
      t.integer :code, null: false, index: { unique: true }
      t.string :name, null: false
      t.monetize :price, null: false, currency: { present: false }
      t.timestamps
    end
  end
end
