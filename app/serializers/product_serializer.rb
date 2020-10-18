class ProductSerializer < ApplicationSerializer
	attributes :code, :name, :price, :currency

	def price
		object.price.to_f
	end

	def currency
		object.price.currency.to_s
	end
end
