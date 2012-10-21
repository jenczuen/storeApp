class Admin::OrdersController < Admin::AdminController
	def index
		@orders = Order.all	
	end

	def show
		@order = Order.find(params[:id])	
		@items = @order.order_items
	end

end