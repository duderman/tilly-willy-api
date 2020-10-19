# frozen_string_literal: true

class ProductSerializer < ApplicationSerializer
  include MoneySerializerHelper

  attributes :code, :name, :price, :currency
end
