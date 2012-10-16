class AddCurrentToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :current, :bool, :default => false
  end
end
