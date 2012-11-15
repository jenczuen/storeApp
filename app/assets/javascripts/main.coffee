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
		@cartContent = []

	init: =>

	setInitialProducts: (products) =>
		@allProducts = products

	setInitialCategories: (categories) =>
		@allCategories = categories

	showHomePage: =>
	showAllCategories: =>

	showCategory: (category_id) => 
		@currentCategory = @allCategories.find((category) -> category.id == category_id)
		@currentProducts = @allProducts.filter (product) -> product.category_id == category_id

	showProduct: (product_id) =>
		@currentProduct = @allProducts.find((product) -> product.id == product_id)
		@currentProductsCategory = null
		for c in @allCategories
			if c.id == @currentProduct.category_id
				@currentProductsCategory = c

	showCart: =>

	addProductToCart: (product_id) =>
		product = @allProducts.find((product) -> product.id == product_id)
		orderItem = @cartContent.find((orderItem) -> orderItem.product.id == product_id)
		if orderItem != undefined
			orderItem.increase()
		else
			@cartContent.add(new OrderItem(product,1))

	removeProductFromCart: (product_id) =>
		orderItem = @cartContent.find((item) -> item.product.id == product_id)
		if orderItem != null
			if orderItem.quantity > 1
				orderItem.decrease()
			else
				@cartContent.remove(orderItem)

	confirmOrder: =>
		#if buyer's personal data not set
		#	useCase.getBuyersPersonalData
		#else 
		#	notthing

	getBuyersPersonalData: =>



class Product
	constructor: (@author, @title, @price, @description, @category_id, @id) ->

class Category
	constructor: (@name, @id) ->

class OrderItem
	constructor: (@product, @quantity) ->
		@total_price = @product.price * @quantity

	increase: =>
		@quantity = @quantity + 1
		@total_price = @product.price * @quantity

	decrease: =>
		@quantity = @quantity - 1
		@total_price = @product.price * @quantity


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
		$("#buyers-data").html("")

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
		source = $("#product-template").html()
		template = Handlebars.compile(source)
		data = {
				author: product.author, 
				title: product.title, 
				price: product.price,
				description: product.description
				function_go_back: "useCase.showCategory("+category.id+")"
				function_add_to_cart: "useCase.addProductToCart("+product.id+")"
				category: category.name
			}
		html = template(data)
		$("#product").html(html)

	showCart: (items) =>
		source = $("#cart-full-template").html()
		template = Handlebars.compile(source)
		data = { orderItems: [] }
		for item in items
			data.orderItems.push({
									author: item.product.author
									title: item.product.title
									price: item.product.price
									id: item.product.id
									function_show: 
										"useCase.showProduct("+item.product.id+")"
									function_remove: 
										"useCase.removeProductFromCart("+item.product.id+")"
									quantity: item.quantity
									total_price: item.total_price
								})
		html = template(data)
		$("#cart-full").html(html)

	showFormForBuyerPersonalData: =>
		$("#buyers-data").html($("#buyers-data-template").html())

class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)

		Before(@useCase, 'init', => @useCase.setInitialProducts(@storage.getProducts()))
		Before(@useCase, 'init', => @useCase.setInitialCategories(@storage.getCategories()))

		Before(@useCase, 'showHomePage', => @gui.clearAll())
		After(@useCase, 'showHomePage', => @gui.showHomePage(@useCase.allProducts))		

		Before(@useCase, 'showAllCategories', => @gui.clearAll())
		After(@useCase, 'showAllCategories', => @gui.showCategories(@useCase.allCategories))

		Before(@useCase, 'showCategory', => @gui.clearAll())
		After(@useCase, 'showCategory', => @gui.showCategory(@useCase.currentCategory,@useCase.currentProducts))

		Before(@useCase, 'showProduct', => @gui.clearAll())
		After(@useCase, 'showProduct', => @gui.showProduct(@useCase.currentProduct,@useCase.currentProductsCategory))

		Before(@useCase, 'showCart', => @gui.clearAll())
		After(@useCase, 'showCart', => @gui.showCart(@useCase.cartContent))

		Before(@useCase, 'addProductToCart', => @gui.clearAll())
		After(@useCase, 'addProductToCart', => @gui.showCart(@useCase.cartContent))

		Before(@useCase, 'removeProductFromCart', => @gui.clearAll())
		After(@useCase, 'removeProductFromCart', => @gui.showCart(@useCase.cartContent))


class Main
	constructor: ->
		gui = new Gui()
		useCase = new NavigationUseCases()
		window.useCase = useCase
		DatabaseApi = new DatabaseApi()
		glue = new Glue(useCase, gui, DatabaseApi)
		useCase.init()
		useCase.showHomePage()

$(-> new Main())