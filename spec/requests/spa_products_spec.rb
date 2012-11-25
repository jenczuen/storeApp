require 'spec_helper'
require 'json'

describe "SpaAPI's" do
  describe "Getting all products from the server - GET /spa/getProducts.json" do
	before do
		product = Product.new
		product.author = "Jedrek"
		product.title = "Plyta"
		product.description = "Opis"
		product.price = 10
		product.category_id = 0
		product.save

		product = Product.new
		product.author = "Michal"
		product.title = "Muza"
		product.description = "Opis2"
		product.price = 22
		product.category_id = 1
		product.save
	end

    it "gets all products from server" do
		get "/spa/getProducts.json"
		response.status.should be(200)
		data = JSON.parse(response.body)

		data[0]["author"].should eq("Jedrek")
		data[0]["title"].should eq("Plyta")
		data[0]["description"].should eq("Opis")
		data[0]["price"].should eq(10)

		data[1]["author"].should eq("Michal")
		data[1]["title"].should eq("Muza")
		data[1]["description"].should eq("Opis2")
		data[1]["price"].should eq(22)
    end
  end
end
