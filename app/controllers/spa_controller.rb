class SpaController < ApplicationController

	def index
	end

	def getProducts
		@products = Product.all()
		respond_to do |format|
			format.json { render :json => @products }
		end
	end

	def getCategories
		@categories = Category.all()
		respond_to do |format|
			format.json { render :json => @categories }
		end
	end

	def echo
		p = Product.new()
		p.author = params[:sample]
#		p.save
		respond_to do |format|
			format.json { render :json => "ok" }
		end
	end

end