require 'spec_helper'
require 'json'

describe "SpaAPI's" do
  describe "Using cart" do

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

      products = Product.all

      @cart = {}
      @cart[:items] = {}
      @cart[:items]["1"] = {}
      @cart[:items]["1"]["product_id"] = products[0].id
      @cart[:items]["1"]["quantity"] = 3
      @cart[:items]["2"] = {} 
      @cart[:items]["2"]["product_id"] = products[1].id
      @cart[:items]["2"]["quantity"] = 4      
    end

    it "sends cart content to the server and receives it as well" do
      post '/spa/sendCart.json', {:items => @cart[:items], :format => :json}
      response.status.should be(200)

      get '/spa/getCart.json'
      response.status.should be(200)

      data = JSON.parse(response.body)

      data[0]["product"]["author"].should eq("Jedrek")
      data[0]["product"]["title"].should eq("Plyta")
      data[0]["product"]["description"].should eq("Opis")
      data[0]["product"]["price"].should eq(10)
      data[0]["product"]["category_id"].should eq(0)

      data[1]["product"]["author"].should eq("Michal")
      data[1]["product"]["title"].should eq("Muza")
      data[1]["product"]["description"].should eq("Opis2")
      data[1]["product"]["price"].should eq(22)
      data[1]["product"]["category_id"].should eq(1)
    end

    it "user sends the cart, server confirms an order, returned cart should be empty" do
      post '/spa/sendCart.json', {:items => @cart[:items], :format => :json}
      response.status.should be(200)

      post "/spa/confirmOrder.json", {:confirm => :order, :format => :json} 
      response.status.should be(200)
      response.body.should eq("ok")

      get '/spa/getCart.json'
      response.status.should be(200)      
      response.body.should eq("[]")
    end

  end
end
