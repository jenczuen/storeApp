class AddPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :int
  end
end
