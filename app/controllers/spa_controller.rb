class SpaController < ApplicationController
	before_filter :set_spa

	def index
	end

	def getProducts
		all = Product.all()
		products = []
		(1..10).each {|i| products.push all[i]}
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

	def echo
		p = Product.new()
		p.author = params[:sample]
#		p.save
		respond_to do |format|
			format.json { render :json => "ok" }
		end
	end

end