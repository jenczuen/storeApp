class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_buyer, :search_object

  def current_buyer
  	if session[:current_buyer_id]
  		@current_buyer = Buyer.find_by_id(session[:current_buyer_id])
  		if @current_buyer == nil
  			@current_buyer = Buyer.create
  			session[:current_buyer_id] = @current_buyer.id
  		end
  	else
  		@current_buyer = Buyer.create
  		session[:current_buyer_id] = @current_buyer.id
  	end
  	@current_buyer
  end

  def search_object
    Product.search
  end
end