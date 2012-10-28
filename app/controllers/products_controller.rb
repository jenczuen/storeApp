class ProductsController < ApplicationController
	def index
		@search = Product.search(params[:q])
		@search_result = @search.result
	end

	def show
		@product = Product.find(params[:id])
	end
end
