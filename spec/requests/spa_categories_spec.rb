require 'spec_helper'
require 'json'

describe "SpaAPI's" do
  describe "Getting all categories from the server - GET /spa/getCategories.json" do
	before do
		category = Category.new
		category.name = "Disco"
		category.save

		category = Category.new
		category.name = "Metal"
		category.save
	end

    it "gets all categories from server" do
		get "/spa/getCategories.json"
		response.status.should be(200)
		data = JSON.parse(response.body)

		data[0]["name"].should eq("Disco")
		data[1]["name"].should eq("Metal")
    end
  end
end
