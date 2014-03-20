class AddInfotextToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :infotext, :string
  end
end
