class Order < ActiveRecord::Base
  attr_accessible :date, :status, :totalPrice
  belongs_to :buyer
  has_many :order_items

  def empty?
  	self.order_items == [] ? true : false
  end

end
