class BuyersController < ApplicationController
	def index
	end

	def cart
		@buyer = current_buyer
		@order = current_buyer.current_order
	end

	def confirmOrder
		@order = Order.find(params[:id])
		if current_buyer.hasAccount?
			@order.current = false
			@order.status = "confirmed"
			@order.save
		end
	end

	def update
		begin
			@buyer = current_buyer
			@buyer.firstName = params[:buyer][:firstName]
			@buyer.secondName = params[:buyer][:secondName]
			@buyer.street = params[:buyer][:street]
			@buyer.city = params[:buyer][:city]			
			@buyer.hasAccount = true
			@buyer.save
			redirect_to '/confirmOrder/'+params[:buyer][:order_id].to_s
		rescue
			redirect_to cart_path
		end
	end
end
