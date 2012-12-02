describe('UseCase', function() {
	
	it('shows small cart', function() {		
		console.log("================ shows small cart")

		var code;
		$("body").append("<div id='test'></div>");
		$("#test").html("");
		code =  "<div id=\"cart-small\"></div>"

		code += "<script type=\"x-handlebars-template\" id=\"cart-small-template\">"
		code += "	{{#if empty}}"
		code += "		Your cart is empty!.<br>"
		code += "	{{else}}"
		code += "		<table border=\"1\" cellpadding=\"6\">"
		code += "			<tr align=\"center\">"
		code += "				<td>Title</td>"
		code += "				<td>Quantity</td>"
		code += "			</tr>"
		code += "			{{#each orderItems}}"
		code += "				<tr align=\"center\">"
		code += "					<td>"
		code += "						<a href=\"#\" onclick={{ this.function_show }}>"
		code += "							{{ this.title }}"
		code += "						</a>	"
		code += "					</td>"
		code += "					<td>{{ this.quantity }}</td>"
		code += "					<td>"
		code += "						<a href=\"#\" onclick={{ this.function_remove }}>"
		code += "							remove from the cart"
		code += "						</a>	"
		code += "					</td>"
		code += "				</tr>"
		code += "			{{/each}}"
		code += "		</table>"
		code += "	{{/if}}"
		code += "</script>	"	
		$("#test").append(code);

		useCase.updateSmallCart();

		expect($("#test")).toHaveText(/Tytul1/);
		expect($("#test")).toHaveText(/1/);
		expect($("#test")).toHaveText(/Tytul2/);
		expect($("#test")).toHaveText(/2/);
		$("#test").html("");
	});

});
