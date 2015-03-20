# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy

  has_one :booking, as: :bookable, dependent: :destroy
  has_one :user, through: :booking
  has_one :realm, through: :booking

  scope :by_realm, -> (realm_id) { joins(:realm).where('bookings.realm_id = ?', realm_id) }

  self.per_page = 10

  before_save :calculate_booking_amount

  private

  def calculate_booking_amount
    booking.amount = order_items.collect(&:total).sum * -1
  end
end
