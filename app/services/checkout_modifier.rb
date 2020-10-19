# frozen_string_literal: true

class CheckoutModifier < ApplicationService
  attr_reader :checkout

  def initialize(checkout)
    @checkout = checkout
  end

  def call
    in_transaction do
      modify_checkout
      recalculate_discounts
    end
    checkout
  end

  private

  def modify_checkout; end

  def recalculate_discounts
    RecalculateDiscounts.call(checkout.items)
  end

  def in_transaction(&block)
    checkout.transaction(&block)
  end
end
