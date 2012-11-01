class UseCase
	contuctor: ->
		@currentProducts = []

	setAllProducts: (products) =>
		@currentProducts = products

	showAllProducts: =>
