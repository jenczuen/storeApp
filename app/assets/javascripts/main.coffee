class DatabaseApi
	constructor: ->
		@json_data = null
		@products = null
		@categories = null
		@buyerData = null
		@basket = null
	
	saveJsonData: (json_data) ->
		@json_data = json_data

	getProducts: =>
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

	sendBasket: (basket) =>
		result = { items: [] }
		for item in basket
			result.items.push(
								product_id: item.product.id
								quantity: item.quantity
							)
		$.ajax({
			type: "POST",
			url: '/spa/sendBasket.json',
			async: false,
			dataType: 'json',
			data: result
		})

	getBasket: =>
		$.ajax({
			url: '/spa/getBasket.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@basket = []
		product = null
		if @json_data != []
			for item in @json_data
				product = new Product(
										item.product.author,
										item.product.title,
										item.product.price,
										item.product.description,
										item.product.category_id,
										item.product.id
									)
				@basket.add( new OrderItem(
											product,
											item.quantity
										))
		else
			@basket = null
		@basket

	sendBuyerData: (buyerData) =>	
		$.ajax({
			type: "POST",
			url: '/spa/sendCurrentBuyer.json',
			async: false,
			dataType: 'json',
			data: {
					"firstName": buyerData.firstName,
					"secondName": buyerData.secondName,
					"street": buyerData.street,
					"city": buyerData.city
				}
		})

	getBuyerData: =>	
		$.ajax({
			url: '/spa/getCurrentBuyer.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		if @json_data.hasAccount == true
			@buyerData = new BuyerData(
										@json_data.firstName,
										@json_data.secondName,
										@json_data.street,
										@json_data.city,
									)
		else
			@buyerData = null
		@buyerData

	getSessionId: =>
		$.ajax({
			url: '/spa/getSessionId.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@sessionId = @json_data.id

	confirmOrder: =>
		@basket = []
		$.ajax({
			type: "POST",
			url: '/spa/confirmOrder.json',
			async: false,
			dataType: 'json',
			data: { "confirm": "order" }
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
		@buyerData = null

	init: =>

	setInitialProducts: (products) =>
		@allProducts = products

	setInitialCategories: (categories) =>
		@allCategories = categories

	setBuyerData: (buyerData) =>
		@buyerData = buyerData

	setBasket: (basket) =>
		@cartContent = basket

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

	updateSmallCart: =>

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
		@cartContent = []
		if @buyerData == null
			@showFormForBuyerPersonalData()
		else
			@orderConfirmed()

	orderConfirmed: =>

	showFormForBuyerPersonalData: =>

	saveBuyerPersonalData: (form) =>
		firstName = form.firstName.value
		secondName = form.secondName.value
		street = form.street.value
		city = form.city.value
		@buyerData = new BuyerData(firstName,secondName,street,city)

	search: =>

	getSearchResults: =>

class BuyerData
	constructor: (@firstName,@secondName,@street,@city) ->

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

	updateSmallCart: (items) =>
		source = $("#cart-small-template").html()
		template = Handlebars.compile(source)
		if items.length < 1
			data = { empty:true }
		else
			data = { orderItems: [] }
			for item in items
				data.orderItems.push({
										title: item.product.title
										function_show: 
											"useCase.showProduct("+item.product.id+")"
										function_remove: 
											"useCase.removeProductFromCart("+item.product.id+")"
										quantity: item.quantity
										total_price: item.total_price
									})
		html = template(data)
		$("#cart-small").html(html)

	showFormForBuyerPersonalData: =>
		source = $("#get-buyers-data-template").html()
		template = Handlebars.compile(source)
		data = {}
		html = template(data)
		$("#buyers-data").html(html)

	showConfirmedOrder: (buyersData) =>
		source = $("#confirm-order-template").html()
		template = Handlebars.compile(source)
		data = { 
					firstName:buyersData.firstName, 
					secondName:buyersData.secondName, 
					street:buyersData.street, 
					city:buyersData.city
				}
		html = template(data)
		$("#buyers-data").html(html)
			

class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)

		Before(@useCase, 'init', => @useCase.setInitialProducts(@storage.getProducts()))
		Before(@useCase, 'init', => @useCase.setInitialCategories(@storage.getCategories()))
		Before(@useCase, 'init', => @useCase.setBuyerData(@storage.getBuyerData()))		
		Before(@useCase, 'init', => @useCase.setBasket(@storage.getBasket()))				
		After(@useCase, 'init', => @useCase.updateSmallCart())		

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

		After(@useCase, 'updateSmallCart', => @gui.updateSmallCart(@useCase.cartContent))

		Before(@useCase, 'addProductToCart', => @gui.clearAll())
		After(@useCase, 'addProductToCart', => @gui.showCart(@useCase.cartContent))
		After(@useCase, 'addProductToCart', => @useCase.updateSmallCart())
		After(@useCase, 'addProductToCart', => @storage.sendBasket(@useCase.cartContent))

		Before(@useCase, 'removeProductFromCart', => @gui.clearAll())
		After(@useCase, 'removeProductFromCart', => @gui.showCart(@useCase.cartContent))
		After(@useCase, 'removeProductFromCart', => @useCase.updateSmallCart())	
		After(@useCase, 'removeProductFromCart', => @storage.sendBasket(@useCase.cartContent))

		Before(@useCase, 'showFormForBuyerPersonalData', => @gui.clearAll())
		After(@useCase, 'showFormForBuyerPersonalData', => @gui.showFormForBuyerPersonalData())

		Before(@useCase, 'saveBuyerPersonalData', => @gui.clearAll())
		After(@useCase, 'saveBuyerPersonalData', => @storage.sendBuyerData(useCase.buyerData))
		After(@useCase, 'saveBuyerPersonalData', => @useCase.orderConfirmed())

		Before(@useCase, 'orderConfirmed', => @storage.confirmOrder())
		Before(@useCase, 'orderConfirmed', => @useCase.updateSmallCart())				
		Before(@useCase, 'orderConfirmed', => @gui.clearAll())
		After(@useCase, 'orderConfirmed', => @gui.showConfirmedOrder(useCase.buyerData))

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