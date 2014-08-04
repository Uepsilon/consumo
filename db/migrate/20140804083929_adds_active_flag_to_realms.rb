class AddsActiveFlagToRealms < ActiveRecord::Migration
  def change
    add_column :realms, :active_flag, :boolean, default: false
  end
end
