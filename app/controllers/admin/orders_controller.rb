class Admin::OrdersController < Admin::AdminController
	def index
		@orders = Order.All	
	end
end