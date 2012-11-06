class GUI
	showProducts: (products) =>
		source   = $("#all-products-template").html()		
		template = Handlebars.compile(source)
		data = {products: products}
		$(".all-products-list").append(template(data))

