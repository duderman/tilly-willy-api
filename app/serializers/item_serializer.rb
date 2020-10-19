# frozen_string_literal: true

class ItemSerializer < ApplicationSerializer
  include MoneySerializerHelper

  attributes :id, :price, :currency, :product_id
end
