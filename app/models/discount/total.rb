# frozen_string_literal: true

class Discount
  class Total < Discount
    store_accessor :configuration, :sum_cents

    validates :sum_cents, presence: true, numericality: { greater_than: 0, only_integer: true }

    def filter_items(items)
      return [] if sum < items.sum(&:price)

      items
    end

    def sum
      MoneyHelper.convert(sum_cents)
    end
  end
end
