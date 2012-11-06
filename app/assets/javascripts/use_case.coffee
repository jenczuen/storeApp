class UseCase
	contuctor: ->
		@currentProducts = []

	setAllProducts: (products) =>
		@currentProducts = products

	getAllProducts: =>
		return @currentProducts

