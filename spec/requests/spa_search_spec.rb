require 'spec_helper'
require 'json'

describe "SpaAPI's" do
  describe "Searching" do
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

    it "sends receives search request and sends proper response" do

		request = {}
		request["title_cont"] = "Plyta"
		request["description_cont"] = "Opis"
		request["author_cont"] = "Jedrek"
		request["price_gteq"] = "5"
		request["price_lteq"] = "20"

		post '/spa/searchProducts.json', {:q => request, :format => :json}
		response.status.should be(200)
		result = JSON.parse(response.body)
		result[0]["author"].should eq("Jedrek")
		result[0]["title"].should eq("Plyta")
		result[0]["description"].should eq("Opis")
		result[0]["price"].should eq(10)
		result[0]["category_id"].should eq(0)
    end

  end
end
