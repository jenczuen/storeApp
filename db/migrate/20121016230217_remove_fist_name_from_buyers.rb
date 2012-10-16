class RemoveFistNameFromBuyers < ActiveRecord::Migration
  def up
    remove_column :buyers, :fistName
  end

  def down
    add_column :buyers, :fistName, :String
  end
end
