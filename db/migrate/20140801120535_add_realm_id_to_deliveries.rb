class AddRealmIdToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :realm_id, :integer, :default => 1
  end
end
