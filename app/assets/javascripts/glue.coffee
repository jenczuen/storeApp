class Glue
 	constructor: (@useCase, @gui, @database)->
    	AutoBind(@gui, @useCase)
		Before(@useCase, 'showAllProducts', => @useCase.setAllProducts(@database.getAllProducts()))
		After(@useCase , 'showAllProducts', => @gui.showProducts(@useCase.todoTasks))