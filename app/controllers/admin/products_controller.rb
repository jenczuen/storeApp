class Admin::ProductsController < Admin::AdminController
	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = product.new(params[:product])
		@product.save
		redirect_to admin_products_path
	end

	def show
		@product = Product.find(params[:id])
		@categories = Category.all
		if @product.category = nil
			@category_id = 0
		else
			@category_id = @product.category.id
		end
	end

	def update
		if params[:product][:category_id] != nil
			product = Product.find(params[:id])
			product.category_id = params[:product][:new_category_id]
			product.save
			if params[:product][:from] == "category"
				redirect_to(admin_category_path params[:product][:category_id])
			end
			if params[:product][:from] == "product"			
				redirect_to(admin_product_path params[:product][:product_id])
			end
		else 

		end
	end

	def destroy
		Product.destroy(params[:id])
		redirect_to admin_product_path
	end

end