#<< utils
#<< database_api
#<< use_case
#<< gui
#<< glue


class Main
	constructor: ->
		useCase = new UseCase()
		window.useCase = useCase
		gui = new GUI()
		database = new DatabaseApi()
		glue = new Glue(useCase, gui, database)
		useCase.showAllProducts()

$(-> new Main())
