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
	end

end