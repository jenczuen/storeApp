class AddFirstNameToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :firstName, :string
  end
end
