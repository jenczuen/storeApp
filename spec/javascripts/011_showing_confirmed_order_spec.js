describe('Gui', function() {
	
	it('shows confirmed order', function() {
		console.log("================ shows confirmed order")

		var code;
		var gui;
		$("body").append("<div id='test'></div>");
		$("#test").html("");
		code =  "<div id=\"buyers-data\"></div>"
		code += "<script type=\"x-handlebars-template\" id=\"confirm-order-template\">"
		code += "	<h1>Order confirmed!</h1>"
		code += "	Your personal data:<br>"
		code += "	First name: {{ firstName }} <br>"
		code += "	Second name: {{ secondName }} <br>"
		code += "	Street: {{ street }} <br>"
		code += "	City: {{ city }} <br><br>"
		code += "	<a href=\"#\" class=\"btn btn-large btn-primary\" onClick=\"useCase.showHomePage()\">"
		code += "		Go back to home page."
		code += "	</a>"
		code += "</script>"
		$("#test").append(code);

		gui = new Gui();
		gui.showConfirmedOrder(useCase.buyerData)

		expect($("#test")).toHaveText(/Imie/);
		expect($("#test")).toHaveText(/Nazwisko/);
		expect($("#test")).toHaveText(/Ulica/);
		expect($("#test")).toHaveText(/Miasto/);

		$("#test").html("");
	});

});
