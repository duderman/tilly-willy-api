# frozen_string_literal: true

module MoneyHelper
  module_function

  def convert(value)
    cents = to_cents(value)
    Money.new(cents, MoneyRails.default_currency)
  end

  def to_cents(value)
    case value
    when Float then (value * 100).round
    when Integer then value
    else raise("Unknown value type for money '#{value.class}'")
    end
  end
end
