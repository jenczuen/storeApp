describe('UseCase', function() {
	
	it('saves categories to itself', function() {
		console.log("================ saves categories to itself")

		var categories = [];

		categories.add(new Category("Category1",1));
		categories.add(new Category("Category2",2));

		useCase.setInitialCategories(categories);

//		console.log(useCase.allCategories);
//		console.log(useCase.allProducts);
	});

});
