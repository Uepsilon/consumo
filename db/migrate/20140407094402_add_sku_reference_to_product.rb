class AddSkuReferenceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sku_id, :integer
  end
end
