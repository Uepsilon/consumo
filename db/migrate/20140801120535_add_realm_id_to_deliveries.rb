class AddRealmIdToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :realm_id, :integer
  end
end
