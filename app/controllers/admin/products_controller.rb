class Admin::ProductsController < Admin::AdminController
	def index
		@products = Product.All
	end

	def update
		if params[:product][:new_category_id] != nil
			product = Product.find(params[:id])
			product.category_id = params[:product][:new_category_id]
			product.save
			redirect_to admin_category_path params[:product][:category_id]
		else
		
		end
	end
end