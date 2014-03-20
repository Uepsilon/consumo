class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer     :amount
      t.references  :order,     null: false
      t.references  :delivery,  null: false

      t.timestamps
    end
  end
end
