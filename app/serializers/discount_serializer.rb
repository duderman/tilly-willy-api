# frozen_string_literal: true

class DiscountSerializer < ApplicationSerializer
  attributes :price, :percentage, :rules
end
