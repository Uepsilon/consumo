class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.integer :amount
      t.decimal :size,  precision: 0, scale: 2
      t.decimal :price, precision: 5, scale: 2

      t.timestamps
    end
  end
end
