class Admin::ProductsController < Admin::AdminController
	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new
		@product.author = params[:product][:author]		
		@product.title = params[:product][:title]
		@product.price = params[:product][:price].to_i
		@product.category_id = 0
		@product.save
		redirect_to admin_products_path
	end

	def show
		@product = Product.find(params[:id])
		@categories = Category.all
		if @product.category == nil
			@category_id = 0
		else
			@category_id = @product.category.id
		end
	end

	def edit
		@product = Product.find(params[:id])
		if params[:change][:title] == ""
			@item = "Biezacy tytul: "
			@text = "Podaj nowy tytul: "
			@key = :title
		end
		if params[:change][:author] == ""
			@item = "Biezacy autor: "
			@text = "Podaj nowego autora: "
			@key = :author			
		end
		if params[:change][:price] == ""
			@item = "Biezaca cena: "
			@text = "Podaj nowa cene: "
			@key = :price			
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
			product = Product.find(params[:id])
			key = params[:product][:change]
			product.title = params[:product][:title] if key == "title"
			product.author = params[:product][:author] if key == "author"
			product.price = params[:product][:price].to_i if key == "price"
			product.save
			redirect_to(admin_product_path params[:id])
		end
	end

	def destroy
		Product.destroy(params[:id])
		redirect_to admin_product_path
	end

end