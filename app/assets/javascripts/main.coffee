class DatabaseApi
	constructor: (@namespace) ->

	getProducts: =>
		[
			new Product("Pezet","Supergirl",10,1), 
			new Product("Gural","Zlota plyta",10,1),
			new Product("Figo Fagot","costam",10,2), 
			new Product("Bajerful","the best",10,2)
		]

	getCategories: =>  
		[
			new Category("HipHop",1), 
			new Category("Dicso Polo",2)
		]

	flush: =>


class NavigationUseCases
	constructor: ->
		@allProducts = []
		@currentProducts = []
		@currentCategory = null
		@allCategories = []

	setInitialProducts: (products) =>
		@allProducts = products

	setInitialCategories: (categories) =>
		@allCategories = categories

	getProductsByCategory: (category_id) => 
#		@currentCategory = new Category("HipHop",1)
#		@currentCategory = new Category("Dicso Polo",2)
		@currentCategory = @allCategories.find((category) -> category.id == category_id)
		@currentProducts = @allProducts.filter (product) -> product.category_id == category_id

	showProductsByCategory: =>		

	showAllProducts: =>
	showAllCategories: =>	

	showProduct: (product) =>
	showCategory: (category) =>


class Product
	constructor: (@author, @title, @price, @category_id) ->


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
			data = {product:true, author: product.author, title: product.title}
			html = template(data)
			$("#items-list").append(html)

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


class Main
	constructor: ->
		gui = new Gui()
		useCase = new NavigationUseCases()
		window.useCase = useCase
		DatabaseApi = new DatabaseApi()
		glue = new Glue(useCase, gui, DatabaseApi)
		useCase.showAllProducts()

$(-> new Main())