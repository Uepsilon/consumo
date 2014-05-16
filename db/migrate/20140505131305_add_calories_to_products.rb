class AddCaloriesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :calories, :integer, null: true, default: 0, after: :name
  end
end
