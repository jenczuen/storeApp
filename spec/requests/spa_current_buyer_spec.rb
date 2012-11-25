require 'spec_helper'
require 'json'

describe "SpaAPI's" do
	describe "Sending to/receiving from the server the current's buyer personal data" do

		it "send buyers personal data and get it back from the server" do
			post '/spa/sendCurrentBuyer.json', {
										:firstName => "Jan",
										:secondName => "Nowak",
										:street => "Trzebnicka",
										:city => "Wroclaw",
										:format => :json
									}
			response.status.should be(200)
			response.body.should eq("ok")	

			get '/spa/getCurrentBuyer.json'
			response.status.should be(200)

			data = JSON.parse(response.body)
			data["firstName"].should eq("Jan")
			data["secondName"].should eq("Nowak")
			data["street"].should eq("Trzebnicka")
			data["city"].should eq("Wroclaw")
		end

	end
end
