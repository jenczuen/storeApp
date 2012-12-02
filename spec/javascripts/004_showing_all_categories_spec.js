describe('UseCase', function() {
	
	it('shows all categories', function() {		
		console.log("================ shows all categories")

		var code;
		$("body").append("<div id='test'></div>");
		$("#test").html("");
		code =  "<div id=\"categories\"></div>"
		code += "<script type=\"x-handlebars-template\" id=\"categories-template\">"
		code += "	<h1> All categories </h1>"
		code += "	<ul class=\"categories_list\">"
		code += "	{{#each categories}}"
		code += "		<li>"
		code += "			<a href=\"#\" onclick={{ this.function_name }}>"
		code += "				{{ this.name }}"
		code += "			</a>"
		code += "		</li>"
		code += "	{{/each}}"
		code += "	</ul>"
		code += "</script>"
		$("#test").append(code);

		useCase.showAllCategories();

		expect($("#test")).toContain("div#categories");
		expect($("#categories")).toContain("ul.categories_list");
		expect($("ul.categories_list")).toHaveText(/Category1/);
		expect($("ul.categories_list")).toHaveText(/Category2/);

		$("#test").html("");
	});

});
