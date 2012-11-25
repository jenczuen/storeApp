class UseCases
	constructor: ->
		@allProducts = []
		@currentProducts = []
		@currentProduct = null
		@currentProductsCategory = null
		@currentCategory = null
		@allCategories = []
		@cartContent = []
		@buyerData = null
		@searchRequest = null
		@initialized = false

	init: =>
		@initialized = true		

	setInitialProducts: (products) =>
		@allProducts = products

	setInitialCategories: (categories) =>
		@allCategories = categories
		@currentProductsCategory = @allCategories[0]

	setBuyerData: (buyerData) =>
		@buyerData = buyerData

	setCart: (cart) =>
		@cartContent = cart

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

	search: (form) =>
		@searchRequest = {
							title_cont:  form.title_cont.value
							description_cont:  form.description_cont.value
							author_cont:  form.author_cont.value
							price_gteq: form.price_gteq.value
							price_lteq: form.price_lteq.value
						}

	getSearchResults: =>
