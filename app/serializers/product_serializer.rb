class ProductSerializer < ApplicationSerializer
	attributes :code, :name, :price, :currency

	def code
		object.code.to_s.rjust(3, '0')
	end

	def price
		object.price.to_f
	end

	def currency
		object.price.currency.to_s
	end
end
