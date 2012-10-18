class AddCurrentToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :current, :boolean, :default => false
  end
end
