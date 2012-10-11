class Product < ActiveRecord::Base
  attr_accessible :name

  belongs_to :category
end
