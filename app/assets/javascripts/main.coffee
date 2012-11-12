class DatabaseApi
	constructor: ->
		@json_data
		@products
		@categories
	
	saveJsonData: (json_data) ->
		@json_data = json_data

	getProducts: =>
		@sendSampleDataViaJson()

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

	getProductsByCategory: (category_id) => 
		@currentCategory = @allCategories.find((category) -> category.id == category_id)
		@currentProducts = @allProducts.filter (product) -> product.category_id == category_id

	showAllProducts: =>
	showAllCategories: =>	

	showProduct: (product_id) =>
		@currentProduct = @allProducts.find((product) -> product.id == product_id)


class Product
	constructor: (@author, @title, @price, @category_id, @id) ->


class Category
	constructor: (@name, @id) ->


class Gui
	constructor: ->
		@productElements = []

	setHeader: (content) =>
		source = $("#header-template").html()
		template = Handlebars.compile(source)
		data = {content: content}
		html = template(data)
		$("#main-header").html(html)

	setButton: (content, function_name) =>
		source = $("#button-template").html()
		template = Handlebars.compile(source)
		data = {content: content, function_name: function_name}
		html = template(data)
		$("#button").html(html)	

	showProducts: (products) =>
		@setButton("Lista kategorii","useCase.showAllCategories()")	
		$("#items-list").html("")
		source = $("#items-template").html()
		template = Handlebars.compile(source)
		for product in products
			data = {
					product:true, 
					author: product.author, 
					title: product.title
					id: product.id
					function_name: "useCase.showProduct("+product.id+")"
				}
			html = template(data)
			$("#items-list").append(html)

	showProduct: (product) =>
		$("#product-view").html("")
		source = $("#product-template").html()
		template = Handlebars.compile(source)
		data = {
				author: product.author, 
				title: product.title, 
				price: product.price
			}
		html = template(data)
		$("#product-view").append(html)

	showCategories: (categories) =>
		@setButton("Strona glowna","useCase.showAllProducts()")		
		$("#items-list").html("")
		source = $("#items-template").html()
		template = Handlebars.compile(source)
		for category in categories
			data = {
					category: true, 
					name: category.name, 
					function_name: "useCase.getProductsByCategory("+category.id+")"
				}
			html = template(data)
			$("#items-list").append(html)


class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)
		Before(@useCase, 'showAllProducts', => @useCase.setInitialProducts(@storage.getProducts()))
		Before(@useCase, 'showAllProducts', => @useCase.setInitialCategories(@storage.getCategories()))
		After(@useCase, 'showAllProducts', => @gui.setHeader("Wszystkie Produkty"))
		After(@useCase, 'showAllProducts', => @gui.showProducts(@useCase.allProducts))

		Before(@useCase, 'showAllCategories', => @useCase.setInitialCategories(@storage.getCategories()))
		After(@useCase, 'showAllCategories', => @gui.setHeader("Wszystkie Kategorie"))
		After(@useCase, 'showAllCategories', => @gui.showCategories(@useCase.allCategories))

		After(@useCase, 'getProductsByCategory', => @gui.setHeader(@useCase.currentCategory.name))
		After(@useCase, 'getProductsByCategory', => @gui.showProducts(@useCase.currentProducts))

		After(@useCase, 'showProduct', => @gui.showProduct(@useCase.currentProduct))


class Main
	constructor: ->
		gui = new Gui()
		useCase = new NavigationUseCases()
		window.useCase = useCase
		DatabaseApi = new DatabaseApi()
		glue = new Glue(useCase, gui, DatabaseApi)
		useCase.showAllProducts()

$(-> new Main())