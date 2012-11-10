class DatabaseApi
	constructor: (@namespace) ->

	getProducts: =>
		return [new Product("Pezet","Supergirl",10,1), new Product("Gural","Zlota plyta",10,1)]

	getCategories: =>  
		return [new Category("HipHop",1), new Category("Dicso Polo",2)]

	flush: =>


class NavigationUseCases
	constructor: ->
		@allProducts = []
		@allCategories = []

	setInitialProducts: (products) =>
		@allProducts = products

	showProductsByCategory: (category) => 
		@allProducts.filter (product) -> product.category_id == category.id

	showAllProducts: =>
	showAllCategories: =>	

	showProduct: (product) =>
	showCategory: (product) =>


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

	showProducts: (products) =>
		@setHeader("Wszystkie produkty")
		$("#products-list").html("")
		source = $("#products-template").html()
		template = Handlebars.compile(source)
		for product in products
			data = {author: product.author, title: product.title}
			html = template(data)
			$("#products-list").append(html)

	showCategories: (categories) =>
		@setHeader("Wszystkie kategorie")
		$("#categories-list").html("")
		source = $("#categories-template").html()
		template = Handlebars.compile(source)
		for category in categories
			data = {name: category.name}
			html = template(data)
			$("#categories-list").append(html)


class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)
		Before(@useCase, 'showAllProducts', => @useCase.setInitialProducts(@storage.getProducts()))
#		After(@useCase, 'showAllProducts', => @gui.showProducts(@storage.getProducts()))
		After(@useCase, 'showAllProducts', => @gui.showCategories(@storage.getCategories()))


class Main
	constructor: ->
		gui = new Gui()
		useCase = new NavigationUseCases()
		window.useCase = useCase
		DatabaseApi = new DatabaseApi()
		glue = new Glue(useCase, gui, DatabaseApi)
		useCase.showAllProducts()

$(-> new Main())