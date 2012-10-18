class OrdersController < ApplicationController
	def addOrderItem
		order = current_buyer.current_order
		#bierzemy wszystkie itemy jakie sa w tym orderze
		items = order.order_items
		product_id = params[:id].to_i
		#sprawdzamy, czy ktoremus itemowi opowiada produkt o takim id
		items.each do |item|
			if item.product.id == product_id
				item.quantity += 1
				item.save
				redirect_to "/cart" 
				return
			end
		end
		#jezeli nie, dodajemy taki item do orderu
		item = order.order_items.create(:quantity => 1)
		#dodajemy produkt do itema
		
		#:product_id => product_id
		#przechodzimy do koszyka
		redirect_to "/cart"
	end
end
