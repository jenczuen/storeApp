class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_buyer, :search_object, :set_spa, :reset_spa, :spa?
  before_filter :reset_spa

  def current_buyer
    if cookies[:current_buyer_id]

      @current_buyer = Buyer.find_by_id(cookies[:current_buyer_id])
      if @current_buyer == nil
        @current_buyer = Buyer.create
        cookies[:current_buyer_id] = { 
                                        :value => @current_buyer.id, 
                                        :expires => 1.week.from_now 
                                      } 
      end

    else
      @current_buyer = Buyer.create
      cookies[:current_buyer_id] = { 
                                    :value => @current_buyer.id, 
                                    :expires => 1.week.from_now 
                                  }
    end

    @current_buyer
  end

  def search_object
    Product.search
  end

  def set_spa
    @spa = true
  end

  def reset_spa
    @spa = false
  end

  def spa?
    @spa
  end

end