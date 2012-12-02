describe('UseCase', function() {
	
	it('shows single category', function() {		
		console.log("================ shows single category")

		var code;
		$("body").append("<div id='test'></div>");
		$("#test").html("");
		code =  "<div id=\"category\"></div>"
		code += "<script type=\"x-handlebars-template\" id=\"category-template\">"
		code += "	<h1> {{ category }} </h1>"
		code += "	<ul class=\"products_list\">"
		code += "	{{#each products}}"
		code += "		<li>"
		code += "			{{ this.author }}"
		code += "			<a href=\"#\" onclick={{ this.function_name }}>"
		code += "				{{ this.title }}"
		code += "			</a>"
		code += "		</li>"
		code += "	{{/each}}"
		code += "	</ul>"
		code += "</script>"
		$("#test").append(code);

		useCase.showCategory(1);

		expect($("#test")).toContain("div#category");
		expect($("#category")).toHaveText(/Category1/);		
		expect($("#category")).toContain("ul.products_list");
		expect($("ul.products_list")).toHaveText(/Autor1/);
		expect($("ul.products_list")).toHaveText(/Tytul2/);
		expect($("ul.products_list")).not.toHaveText(/Autor3/);

		$("#test").html("");
	});

});
