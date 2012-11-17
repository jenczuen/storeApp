class SpaController < ApplicationController
	before_filter :set_spa

	def index
	end

	def getProducts
		products = Product.all()
		respond_to do |format|
			format.json { render :json => products }
		end
	end

	def getCategories
		@categories = Category.all()
		respond_to do |format|
			format.json { render :json => @categories }
		end
	end

	def getSessionId
		current_buyer
		respond_to do |format|
			format.json { render :json => session[:current_buyer_id] }
		end
	end

	def getCurrentBuyer
		respond_to do |format|
			format.json { render :json => current_buyer }
		end
	end

	def	sendCurrentBuyer
		b = Buyer.last()
		b.firstName = params[:firstName]
		b.secondName = params[:secondName]
		b.street = params[:street]
		b.city = params[:city]
		b.hasAccount = true
		b.save
		puts b
		respond_to do |format|
			format.json { render :json => "ok" }
		end
	end

	def getBasket
		order = current_buyer.current_order
		basket = []
		for item in order.order_items
			basket.push({:product => item.product, :quantity => item.quantity})
		end
		respond_to do |format|
			format.json { render :json =>  basket}
		end		
	end

	def sendBasket
		order = current_buyer.current_order
		items = order.order_items
		for new_item in params[:items]
			product_id = new_item[1][:product_id]
			quantity = new_item[1][:quantity]
			#szukamy czy taki juz jest
			items.each do |item|
				#jak jest to ustawiamy ilosc i zapisujemy
				if item.product.id == product_id
					item.quantity = quantity
					item.priceForAll = item.product.price*quantity
					item.save
					return
				end
			end
			#jezeli nie to dodajemy
			item = order.order_items.create(:quantity => 1)
			item.product_id = product_id
			item.save
			item.priceForAll = item.product.price
			item.save
		end
		respond_to do |format|
			format.json { render :json => "ok" }
		end
	end

end