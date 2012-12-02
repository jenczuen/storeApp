describe('UseCase', function() {
	
	it('shows homepage', function() {		
		console.log("================ shows homepage")

		var code;
		$("body").append("<div id='test'></div>");
		$("#test").html("");
		code =  "<div id=\"home-page\"></div>"
		code += "<script type=\"x-handlebars-template\" id=\"home-page-template\">"
		code += "	<h1> Welcome! </h1>"
		code += "	<ul class=\"products_list\">"
		code += "		{{#each products}}"
		code += "		<li>"
		code += "			{{ this.author }}"
		code += "			<a href=\"#\" onclick={{ this.function_name }}>"
		code += "			{{ this.title }}"
		code += "			</a>"
		code += "		</li>"
		code += "		{{/each}}"
		code += "	</ul>"
		code += "</script>"
		$("#test").append(code);

		useCase.showHomePage();

		expect($("#test")).toContain("div#home-page");
		expect($("#home-page")).toContain("ul.products_list");
		expect($("ul.products_list")).toHaveText(/Autor1/);
		expect($("ul.products_list")).toHaveText(/Tytul4/);

		$("#test").html("");
	});

});
