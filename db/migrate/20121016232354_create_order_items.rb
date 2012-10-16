class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.integer :priceForAll

      t.timestamps
    end
  end
end
