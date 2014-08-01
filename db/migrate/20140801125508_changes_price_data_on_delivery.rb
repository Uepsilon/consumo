class ChangesPriceDataOnDelivery < ActiveRecord::Migration
  def up
    add_column :deliveries, :price, :decimal, precision: 7, scale: 2

    Delivery.all.each do |delivery|
      delivery.price = delivery.booking.amount.to_f
      delivery.save!
    end

    remove_column :deliveries, :unit_price
  end

  def down
    add_column :deliveries, :unit_price, :decimal, precision: 5, scale: 2

    Delivery.all.each do |delivery|
      delivery.unit_price = delivery.unit_price
      delivery.save!
    end

    remove_column :deliveries, :price
  end
end
