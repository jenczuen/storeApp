class DatabaseApi
	constructor: ->
		@json_data
		@products
		@categories
	
	saveJsonData: (json_data) ->
		@json_data = json_data

	getProducts: =>
#		@sendSampleDataViaJson()

		$.ajax({
			url: '/spa/getProducts.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@products = []
		for item in @json_data
			@products.add( new Product(
										item.author,
										item.title,
										item.price,
										item.description,
										item.category_id,
										item.id
									))
		@products

	getCategories: =>  
		$.ajax({
			url: '/spa/getCategories.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@categories = []
		for item in @json_data
			@categories.add( new Category(
										item.name,
										item.id
									))
		@categories

	sendSampleDataViaJson: =>
		$.ajax({
			type: "POST",
			url: '/spa/echo',
			async: false,
			dataType: 'json',
#			processData : false,
			data: {"sample": "data"}
		})

	flush: =>
		@json_data = []
		@products = []
		@categories = []


class NavigationUseCases
	constructor: ->
		@allProducts = []
		@currentProducts = []
		@currentProduct = null
		@currentProductsCategory = null
		@currentCategory = null
		@allCategories = []

	setInitialProducts: (products) =>
		@allProducts = products

	setInitialCategories: (categories) =>
		@allCategories = categories

	showCategory: (category_id) => 
		@currentCategory = @allCategories.find((category) -> category.id == category_id)
		@currentProducts = @allProducts.filter (product) -> product.category_id == category_id

	showAllProducts: =>
	showAllCategories: =>	

	showProduct: (product_id) =>
		@currentProduct = @allProducts.find((product) -> product.id == product_id)
		@currentProductsCategory = null
		for c in @allCategories
			if c.id == @currentProduct.category_id
				@currentProductsCategory = c


class Product
	constructor: (@author, @title, @price, @description, @category_id, @id) ->


class Category
	constructor: (@name, @id) ->


class Gui
	constructor: ->
		@productElements = []

	clearAll: =>
		$("#home-page").html("")
		$("#categories").html("")
		$("#category").html("")
		$("#product").html("")
		$("#cart-full").html("")
		$("#confirm-order").html("")

	showHomePage: (products) =>
		source = $("#home-page-template").html()
		template = Handlebars.compile(source)
		data = { products: [] }
		for product in products
			data.products.push({
									author: product.author
									title: product.title
									id: product.id
									function_name: "useCase.showProduct("+product.id+")"
								})
		html = template(data)
		$("#home-page").html(html)

	showCategories: (categories) =>
		source = $("#categories-template").html()
		template = Handlebars.compile(source)
		data = { categories: [] }
		for category in categories
			data.categories.push({
									name: category.name
									function_name: "useCase.showCategory("+category.id+")"
								})
		html = template(data)
		$("#categories").html(html)

	showCategory: (category,products) =>
		source = $("#category-template").html()
		template = Handlebars.compile(source)
		data = { category: category.name, products: [] }
		for product in products
			data.products.push({
									author: product.author
									title: product.title
									id: product.id
									function_name: "useCase.showProduct("+product.id+")"
								})
		html = template(data)
		$("#category").html(html)

	showProduct: (product, category) =>
#	showProduct: (product) =>
		source = $("#product-template").html()
		template = Handlebars.compile(source)
		data = {
				author: product.author, 
				title: product.title, 
				price: product.price,
				description: product.description
				function_name: "useCase.showCategory("+category.id+")"
				category: category.name
			}
		html = template(data)
		$("#product").html(html)


class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)
		Before(@useCase, 'showAllProducts', => @useCase.setInitialProducts(@storage.getProducts()))
		Before(@useCase, 'showAllProducts', => @useCase.setInitialCategories(@storage.getCategories()))
		Before(@useCase, 'showAllProducts', => @gui.clearAll())
		After(@useCase, 'showAllProducts', => @gui.showHomePage(@useCase.allProducts))		

		Before(@useCase, 'showAllCategories', => @gui.clearAll())
		After(@useCase, 'showAllCategories', => @gui.showCategories(@useCase.allCategories))

		Before(@useCase, 'showCategory', => @gui.clearAll())
		After(@useCase, 'showCategory', => @gui.showCategory(@useCase.currentCategory,@useCase.currentProducts))

		Before(@useCase, 'showProduct', => @gui.clearAll())
#		After(@useCase, 'showProduct', => @gui.showProduct(@useCase.currentProduct))
		After(@useCase, 'showProduct', => @gui.showProduct(@useCase.currentProduct,@useCase.currentProductsCategory))


class Main
	constructor: ->
		gui = new Gui()
		useCase = new NavigationUseCases()
		window.useCase = useCase
		DatabaseApi = new DatabaseApi()
		glue = new Glue(useCase, gui, DatabaseApi)
		useCase.showAllProducts()

$(-> new Main())