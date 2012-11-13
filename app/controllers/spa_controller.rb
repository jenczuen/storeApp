class SpaController < ApplicationController

	def index
		product = Product.first()
		@product_json = ActiveSupport::JSON.encode(product)
	end

end