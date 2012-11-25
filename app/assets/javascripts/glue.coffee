class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)

		Before(@useCase, 'init', => @useCase.setInitialProducts(@storage.getProducts()))
		Before(@useCase, 'init', => @useCase.setInitialCategories(@storage.getCategories()))
		Before(@useCase, 'init', => @useCase.setBuyerData(@storage.getBuyerData()))		
		Before(@useCase, 'init', => @useCase.setCart(@storage.getCart()))				
		After(@useCase, 'init', => @useCase.updateSmallCart())		

		Before(@useCase, 'showHomePage', => @gui.clearAll())
		After(@useCase, 'showHomePage', => @gui.showHomePage(@useCase.allProducts))		

		Before(@useCase, 'showAllCategories', => @gui.clearAll())
		After(@useCase, 'showAllCategories', => @gui.showCategories(@useCase.allCategories))

		Before(@useCase, 'showCategory', => @gui.clearAll())
		After(@useCase, 'showCategory', => @gui.showCategory(@useCase.currentCategory,@useCase.currentProducts))

		Before(@useCase, 'showProduct', => @gui.clearAll())
		After(@useCase, 'showProduct', => @gui.showProduct(@useCase.currentProduct,@useCase.currentProductsCategory))

		Before(@useCase, 'showCart', => @gui.clearAll())
		After(@useCase, 'showCart', => @gui.showCart(@useCase.cartContent,@useCase.buyerData))

		After(@useCase, 'updateSmallCart', => @gui.updateSmallCart(@useCase.cartContent))

		Before(@useCase, 'addProductToCart', => @gui.clearAll())
		After(@useCase, 'addProductToCart', => @gui.showCart(@useCase.cartContent,@useCase.buyerData))
		After(@useCase, 'addProductToCart', => @useCase.updateSmallCart())
		After(@useCase, 'addProductToCart', => @storage.sendCart(@useCase.cartContent))

		Before(@useCase, 'removeProductFromCart', => @gui.clearAll())
		After(@useCase, 'removeProductFromCart', => @gui.showCart(@useCase.cartContent,@useCase.buyerData))
		After(@useCase, 'removeProductFromCart', => @useCase.updateSmallCart())	
		After(@useCase, 'removeProductFromCart', => @storage.sendCart(@useCase.cartContent))

		Before(@useCase, 'showFormForBuyerPersonalData', => @gui.clearAll())
		After(@useCase, 'showFormForBuyerPersonalData', => @gui.showFormForBuyerPersonalData())

		Before(@useCase, 'saveBuyerPersonalData', => @gui.clearAll())
		After(@useCase, 'saveBuyerPersonalData', => @storage.sendBuyerData(@useCase.buyerData))
		After(@useCase, 'saveBuyerPersonalData', => @useCase.orderConfirmed())

		Before(@useCase, 'orderConfirmed', => @storage.confirmOrder())
		Before(@useCase, 'orderConfirmed', => @useCase.updateSmallCart())				
		Before(@useCase, 'orderConfirmed', => @gui.clearAll())
		After(@useCase, 'orderConfirmed', => @gui.showConfirmedOrder(@useCase.buyerData))

		After(@useCase, 'search', => @storage.sendSearchRequest(@useCase.searchRequest))
		After(@useCase, 'search', => @gui.clearAll())
		After(@useCase, 'search', => @gui.showSearchResult(@storage.searchResult))

		LogAll(@useCase)
		LogAll(@gui)
