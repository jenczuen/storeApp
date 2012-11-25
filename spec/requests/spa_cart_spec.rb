require 'spec_helper'
require 'json'

describe "SpaAPI's" do
  describe "Sending to/receiving from the server cart content" do

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

    it "sends cart content to the server" do
      products = Product.all

      cart = {}
      cart[:items] = {}
      cart[:items]["1"] = {}
      cart[:items]["1"]["product_id"] = products[0].id
      cart[:items]["1"]["quantity"] = 3
      cart[:items]["2"] = {} 
      cart[:items]["2"]["product_id"] = products[1].id
      cart[:items]["2"]["quantity"] = 4

      open_session do |session|
        session.get '/spa/'
        session.response.status.should be(200)

        session.post '/spa/sendCart.json', {:items => cart[:items], :format => :json}
        session.response.status.should be(200)

        session.get '/spa/getCategories.json'
        session.response.status.should be(200)

        data = JSON.parse(session.response.body)
        puts data
      end
    end

=begin
    it "gets cart content from the server, it should be the same as this just sent" do
      get '/spa/getCategories.json'
      response.status.should be(200)

      data = JSON.parse(response.body)
      puts data

      get '/spa/getSessionId.json'
      puts response.body
    end
=end

    it "server confirms an order" do

    end

  end
end
