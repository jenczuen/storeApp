class Main
	constructor: ->
		gui = new Gui()
		window.useCase = new UseCases()
		databaseApi = new DatabaseApi()
		glue = new Glue(useCase, gui, databaseApi)
		useCase.init()
		useCase.showHomePage()

$(-> new Main())