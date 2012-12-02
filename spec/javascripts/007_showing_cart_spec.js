	describe('UseCase', function() {

	it('saves cart', function(){
		console.log("================ saves cart")

		var order_items = [];

		order_items.add(new OrderItem(useCase.allProducts[0],1));
		order_items.add(new OrderItem(useCase.allProducts[1],5));

		useCase.setCart(order_items);		

	});
	
	it('shows cart without buyers name', function() {		
		console.log("================ shows cart without buyers name")

		var code;
		$("body").append("<div id='test'></div>");
		$("#test").html("");
		code =  "<div id=\"cart-full\"></div>"
		code += "<script type=\"x-handlebars-template\" id=\"cart-full-template\">"
		code += "	<h1> Your cart </h1>"
		code += "	<center>"
		code += "	{{#if hasAccount}}"
		code += "		Hello {{ firstName }}<br>"
		code += "	{{else}}"
		code += "		You dont have an account yet!<br>"
		code += "	{{/if}}"
		code += "	{{#if empty}}"
		code += "		Your cart is empty! <br><br>"
		code += "	{{else}}"
		code += "		List of items in your cart: <br>"
		code += "		<table border=\"1\" cellpadding=\"6\">"
		code += "			<tr align=\"center\">"
		code += "				<td>Author</td>"
		code += "				<td>Title</td>"
		code += "				<td>Quantity</td>"
		code += "				<td>Price for one</td>"
		code += "				<td>Price for all</td>"
		code += "			</tr>"
		code += "			{{#each orderItems}}"
		code += "				<tr align=\"center\">"
		code += "					<td>{{ this.author }}</td>"
		code += "					<td>"
		code += "						<a href=\"#\" onclick={{ this.function_show }}>"
		code += "							{{ this.title }}"
		code += "						</a>	"
		code += "					</td>"
		code += "					<td>{{ this.quantity }}</td>"
		code += "					<td>{{ this.price }}</td>"
		code += "					<td>{{ this.total_price }}</td>"
		code += "					<td>"
		code += "						<a href=\"#\" onclick={{ this.function_remove }}>"
		code += "							remove from the cart"
		code += "						</a>	"
		code += "					</td>"
		code += "				</tr>"
		code += "			{{/each}}"
		code += "		</table>"
		code += "		<br>"
		code += "		<a href=\"#\" class=\"btn btn-large btn-primary\" onClick=\"useCase.confirmOrder()\">"
		code += "			Confirm order."
		code += "		</a>"
		code += "	{{/if}}"
		code += "	<a href=\"#\" class=\"btn btn-large btn-primary\" onClick={{ goBackFunction }}>"
		code += "		Continue shopping."
		code += "	</a>"
		code += "	</center>	"
		code += "</script>"
		$("#test").append(code);

		useCase.showCart();

		expect($("#test")).toHaveText(/You dont have an account yet/);
		expect($("#test")).toContain("div#cart-full");
		expect($("div#cart-full")).toHaveText(/Autor1/);
		expect($("div#cart-full")).toHaveText(/Autor2/);
		expect($("div#cart-full")).toHaveText(/Tytul1/);
		expect($("div#cart-full")).toHaveText(/Tytul2/);
		expect($("div#cart-full")).toHaveText(/100/);
		$("#test").html("");
	});

});
