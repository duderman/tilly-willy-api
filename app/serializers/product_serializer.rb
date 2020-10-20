# frozen_string_literal: true

class ProductSerializer < ApplicationSerializer
  include MoneySerializerHelper

  attributes :id, :code, :name, :price, :currency
end
