class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.references  :product,     null: false
      t.integer     :quantity,    null: false
      t.decimal     :unit_price,  precision: 5, scale: 2

      t.timestamps
    end
  end
end
