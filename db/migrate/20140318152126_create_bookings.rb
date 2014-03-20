class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references  :user,    null: false
      t.decimal     :amount,  precision: 5, scale: 2, null: false

      t.belongs_to  :bookable, polymorphic: true

      t.timestamps
    end

    add_index :bookings, [:bookable_id, :bookable_type], name: :bookable
  end
end
