class AddHasAccountToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :hasAccount, :bool, :default => false
  end
end
