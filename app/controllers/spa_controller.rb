class SpaController < ApplicationController
	before_filter :set_spa

	def index
		current_buyer
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

	def getCart
		order = current_buyer.current_order
		cart = []
		for item in order.order_items
			cart.push({:product => item.product, :quantity => item.quantity})
		end
		respond_to do |format|
			format.json { render :json =>  cart}
		end		
	end

	def sendCart
		#not the best way but works
		order = current_buyer.current_order
		#remove all
		order.order_items.each {|i| i.delete}	
		if params[:items] != nil
			#add from scratch
			for new_item in params[:items]
				product_id = new_item[1][:product_id]
				quantity = new_item[1][:quantity]

				i = order.order_items.create(:quantity => quantity)
				i.product_id = product_id
				i.save
				i.priceForAll = i.product.price
				i.save			
			end
		end
		respond_to do |format|
			format.json { render :json => "ok" }
		end
	end

	def confirmOrder
		order = current_buyer.current_order
		order.current = false
		order.status = "confirmed"
		order.save
		respond_to do |format|
			format.json { render :json => "ok" }
		end
	end

	def searchProducts
		search = Product.search(params[:q])
		search_result = search.result
		respond_to do |format|
			format.json { render :json => search_result }
		end
	end

end