class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :fistName
      t.string :secondName
      t.string :city
      t.string :street
      t.string :postalCode
      t.string :phoneNumber

      t.timestamps
    end
  end
end
