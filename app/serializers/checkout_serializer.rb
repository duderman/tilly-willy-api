# frozen_string_literal: true

class CheckoutSerializer < ApplicationSerializer
  attributes :id
  has_many :items, serializer: ItemSerializer
  has_many :discounts

  def discounts
    object.items.map(&:discount).compact.uniq
  end
end
