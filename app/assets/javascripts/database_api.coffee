class DatabaseApi
	constructor: ->
		@json_data = null
		@products = null
		@categories = null
		@buyerData = null
		@cart = null
		@searchResult = null
	
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

	sendCart: (cart) =>
		result = { items: [] }
		for item in cart
			result.items.push(
								product_id: item.product.id
								quantity: item.quantity
							)
		$.ajax({
			type: "POST",
			url: '/spa/sendCart.json',
			async: false,
			dataType: 'json',
			data: result
		})

	getCart: =>
		$.ajax({
			url: '/spa/getCart.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@cart = []
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
				@cart.add( new OrderItem(
											product,
											item.quantity
										))
		else
			@cart = null
		@cart

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
		@cart = []
		$.ajax({
			type: "POST",
			url: '/spa/confirmOrder.json',
			async: false,
			dataType: 'json',
			data: { "confirm": "order" }
		})

	sendSearchRequest: (request) =>
		$.ajax({
			type: "POST",
			url: '/spa/searchProducts.json',
			async: false,
			dataType: 'json',
			data: { q : request }
			success: (data, status) => @saveJsonData(data)
		})
		@searchResult = []
		for item in @json_data
			@searchResult.add( new Product(
										item.author,
										item.title,
										item.price,
										item.description,
										item.category_id,
										item.id
									))
		@searchResult

	flush: =>
		@json_data = null
		@products = null
		@categories = null
		@buyerData = null
		@cart = null
		@searchResult = null
