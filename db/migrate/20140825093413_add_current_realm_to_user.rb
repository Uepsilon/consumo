class AddCurrentRealmToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_realm_id, :integer
  end
end
