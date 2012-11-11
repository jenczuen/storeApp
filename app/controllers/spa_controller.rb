class SpaController < ApplicationController

#	respond_to :json

	def index
	end

	def getProducts
		@product = Product.first()
#		respond_with(@product)
#		respond_with("chuj")
		respond_to do |format|
			format.json { render :json => @product }
		end
	end

end