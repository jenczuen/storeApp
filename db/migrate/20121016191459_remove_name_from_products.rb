class RemoveNameFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :name
  end

  def down
    add_column :products, :name, :string
  end
end
