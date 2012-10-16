class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :date
      t.string :status
      t.integer :totalPrice

      t.timestamps
    end
  end
end
