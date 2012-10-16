class Buyer < ActiveRecord::Base
  attr_accessible :city, :fistName, :phoneNumber, :postalCode, :secondName, :street

  has_many :orders

  def hasAccount?
    hasAccount == 't' ? true : false
  end

  #ta metode koniecznie trzeba poprawic!!!!!!
  def current_order
 	orders = self.orders
 	@current_order = nil
 	for order in orders
  		@current_order = order if order.current?
  	end
  	
  	if @current_order == nil
  		@current_order = self.orders.create
  		@current_order.current = true
  		@current_order.save
  	end
  	@current_order
  end

end
