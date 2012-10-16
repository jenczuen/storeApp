class Order < ActiveRecord::Base
  attr_accessible :date, :status, :totalPrice
  belongs_to :buyer

  def empty?
  	true
  end
end
