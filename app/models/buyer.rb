class Buyer < ActiveRecord::Base
  attr_accessible :city, :fistName, :phoneNumber, :postalCode, :secondName, :street

  has_many :orders
end
