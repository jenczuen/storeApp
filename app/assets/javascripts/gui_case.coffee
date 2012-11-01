class GUI
	showProducts: (tasks) =>
		source   = $("#all-products-template").html()		
		template = Handlebars.compile(source)
		data = {tasks: tasks}
		$(".all-products-list").append(template(data))

