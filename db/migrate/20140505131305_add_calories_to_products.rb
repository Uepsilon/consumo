class AddCaloriesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :calories, :integer, null: false, default: 0, after: :name
  end
end
