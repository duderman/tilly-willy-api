# frozen_string_literal: true

class Discount < ApplicationRecord
  monetize :price_cents, allow_nil: true, numericality: { greater_than: 0 }

  validates :type, presence: true
  validates :configuration, presence: true
  validates :percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100, only_integer: true,
                                         allow_nil: true }
  validate :discount_amount_configured

  private

  def discount_amount_configured
    return if percentage.nil? ^ price_cents.nil?

    errors.add(:base, 'should have either percentage or price configured')
  end
end
