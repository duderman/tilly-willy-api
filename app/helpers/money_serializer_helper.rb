# frozen_string_literal: true

module MoneySerializerHelper
  def price
    object.price&.to_f
  end

  def currency
    object.price&.currency&.to_s
  end
end
