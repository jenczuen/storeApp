class Admin::CategoriesController < Admin::AdminController
	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params[:category])
		@category.save
		redirect_to admin_categories_path
	end

	def show
		@category = Category.find(params[:id])
		@products = Product.all
	end

	def update
	end

	def edit
	end

	def destroy
		Category.destroy(params[:id])
		redirect_to admin_categories_path
	end
end