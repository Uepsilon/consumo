class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.string :title
      t.string :short

      t.timestamps
    end
  end
end
