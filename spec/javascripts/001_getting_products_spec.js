describe('UseCase', function() {
	
	it('saves products to itself', function() {
		console.log("================ saves products to itself")

		var products = [];
		var allProducts = [];
		var autor;

		products.add(new Product("Autor1","Tytul1",10,"Description1",1,1));
		products.add(new Product("Autor2","Tytul2",20,"Description2",1,2));
		products.add(new Product("Autor3","Tytul3",30,"Description3",2,3));
		products.add(new Product("Autor4","Tytul4",40,"Description4",2,4));

		useCase.setInitialProducts(products);

		autor = useCase.allProducts[0].author
//		console.log(autor);
//		expect.(author).toMatch('Autor1')
//		console.log(useCase.allProducts);	
	});

});
