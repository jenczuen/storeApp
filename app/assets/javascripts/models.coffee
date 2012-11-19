class window.Product
	constructor: (@author, @title, @price, @description, @category_id, @id) ->

class window.BuyerData
	constructor: (@firstName,@secondName,@street,@city) ->

class window.Category
	constructor: (@name, @id) ->

class window.OrderItem
	constructor: (@product, @quantity) ->
		@total_price = @product.price * @quantity

	increase: =>
		@quantity = @quantity + 1
		@total_price = @product.price * @quantity

	decrease: =>
		@quantity = @quantity - 1
		@total_price = @product.price * @quantity
