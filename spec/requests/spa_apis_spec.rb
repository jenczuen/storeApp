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

    it "gest product from server" do
		get "/spa/getProducts.json"
		response.status.should be(200)
		data = JSON.parse(response.body)

		puts data[0].author
    end
  end
end
