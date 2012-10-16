class AddFirstNameToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :firstName, :String
  end
end
