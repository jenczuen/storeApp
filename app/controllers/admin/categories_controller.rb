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
		@category = Category.find(params[:id])
		@category.name = params[:category][:name]
		@category.save
		redirect_to admin_categories_path(params[:id])
	end

	def edit
		@category = Category.find(params[:id])
	end

	def destroy
		category = Category.find(params[:id])
		products = category.products
		category.destroy
		products.each do |p|
			p.category_id = 0
			p.save
		end
		redirect_to admin_categories_path
	end
end