describe('UseCase', function() {
	
	it('shows single product', function() {		
		console.log("================ shows single product")

		var code;
		$("body").append("<div id='test'></div>");
		$("#test").html("");
		code =  "<div id=\"product\"></div>"
		code += "<script type=\"x-handlebars-template\" id=\"product-template\">"
		code += "	<h1> {{ title }} </h1>"
		code += "	<div> "
		code += "		Author: {{ author }} <br>"
		code += "		Price: {{ price }} <br>"
		code += "		Description: {{ description }}"
		code += "	</div>"
		code += "	<a href=\"#\" onclick={{ function_add_to_cart }}>"
		code += "		Add product to cart"
		code += "	</a> <br>"
		code += "	<a href=\"#\" onclick={{ function_go_back }}>"
		code += "		Go to {{ category }}"
		code += "	</a>"
		code += "</script>"
		$("#test").append(code);

		useCase.showProduct(1);

		expect($("#test")).toContain("div#product");
		expect($("#product")).toHaveText(/Tytul1/);
		expect($("#product")).toHaveText(/Autor1/);
		expect($("#product")).toHaveText(/10/);
		expect($("#product")).toHaveText(/Description1/);
		expect($("#product")).toHaveText(/Category1/);
		$("#test").html("");
	});

});
