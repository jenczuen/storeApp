class AddHasAccountToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :hasAccount, :boolean, :default => false
  end
end
