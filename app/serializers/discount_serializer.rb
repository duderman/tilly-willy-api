# frozen_string_literal: true

class DiscountSerializer < ApplicationSerializer
  include MoneySerializerHelper

  attribute :percentage, if: :percentage?
  attribute :price, if: :price?
  attribute :currency, if: :price?
  attributes :rules

  def price?
    !object.price.nil?
  end

  def percentage?
    !object.percentage.nil?
  end
end
