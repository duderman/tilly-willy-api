# frozen_string_literal: true

class Discount
  class Total < Discount
    store_accessor :configuration, :sum

    validates :sum, presence: true, numericality: { greater_than: 0 }
  end
end
