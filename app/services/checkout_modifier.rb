# frozen_string_literal: true

class CheckoutModifier < ApplicationService
  attr_reader :checkout

  def initialize(checkout)
    @checkout = checkout
  end

  def call
    modify_checkout
    recalculate_discounts
    checkout
  end

  private

  def modify_checkout; end

  def recalculate_discounts
    RecalculateDiscounts.call(checkout.items)
  end
end
