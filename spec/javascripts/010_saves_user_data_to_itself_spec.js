describe('UseCase', function() {
	
	it('saves user data to itself', function() {
		console.log("================ saves user data to itself")

		data = new BuyerData(
								"Imie",
								"Nazwisko",
								"Ulica",
								"Miasto"
							)

		useCase.setBuyerData(data);

		expect(useCase.buyerData.firstName).toMatch(/Imie/);
		expect(useCase.buyerData.secondName).toMatch(/Nazwisko/);
		expect(useCase.buyerData.street).toMatch(/Ulica/);
		expect(useCase.buyerData.city).toMatch(/Miasto/);
	});

});
