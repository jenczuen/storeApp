class window.Gui
	constructor: ->

	clearAll: =>
		$("#home-page").html("")
		$("#categories").html("")
		$("#category").html("")
		$("#product").html("")
		$("#cart-full").html("")
		$("#confirm-order").html("")
		$("#buyers-data").html("")
		$("#search-result").html("")

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

	showCart: (items,buyerData) =>
		source = $("#cart-full-template").html()
		template = Handlebars.compile(source)
		if buyerData
			hasAccount = true
			firstName = buyerData.firstName
		else
			hasAccount = false
			firstName = ""

		if items.length < 1
			goBackFunction = "useCase.showHomePage()"
			empty = true
		else
			category_id = items[items.length-1].product.category_id
			goBackFunction = "useCase.showCategory("+category_id+")"
			empty = false

		data = { 
					empty: empty
					goBackFunction: goBackFunction, 
					orderItems: [],
					hasAccount,
					firstName
				}
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

	showSearchResult: (products) =>
		source = $("#search-result-template").html()
		template = Handlebars.compile(source)
		empty = false
		if products.length < 1
			empty = true
		data = { 
					empty: empty, 
					products: [] 
				}
		for product in products
			data.products.push({
									author: product.author
									title: product.title
									id: product.id
									function_name: "useCase.showProduct("+product.id+")"
								})
		html = template(data)
		$("#search-result").html(html)