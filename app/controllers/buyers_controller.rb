class BuyersController < ApplicationController
	def index
	end

	def cart
		@buyer = current_buyer
		@order = current_buyer.current_order
	end
end
