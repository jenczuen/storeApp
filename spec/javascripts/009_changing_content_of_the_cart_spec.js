describe('UseCase', function() {
	var uc = new UseCases();	

	it('adds product to the cart', function() {		
		console.log("================ adds product to the cart")
		var order_items = [];
		var products = [];

		uc.cartContent = [];
		products.add(new Product("Autor1","Tytul1",10,"Description1",1,1));
		products.add(new Product("Autor2","Tytul2",20,"Description2",1,2));
		uc.setInitialProducts(products);

		uc.addProductToCart(1);
		expect(uc.cartContent[0].product.id).toEqual(1);
		expect(uc.cartContent[0].quantity).toEqual(1);

		uc.addProductToCart(1);
		expect(uc.cartContent[0].product.id).toEqual(1);
		expect(uc.cartContent[0].quantity).toEqual(2);

	});

	it('removes product from the cart', function() {		
		console.log("================ removes product from the cart")

		uc.removeProductFromCart(1);
		expect(uc.cartContent[0].product.id).toEqual(1);
		expect(uc.cartContent[0].quantity).toEqual(1);

		uc.removeProductFromCart(1);
		expect(uc.cartContent).toEqual([]);

	});

});
