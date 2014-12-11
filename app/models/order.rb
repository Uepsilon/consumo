# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base
  has_many    :order_items, dependent: :destroy

  has_one     :booking,  as: :bookable, dependent: :destroy
  has_one     :user,     through: :booking
  has_one     :realm,    through: :booking

  scope :current_realm, -> (realm_id) { joins(:realm).where('bookings.realm_id = ?', realm_id) }

  self.per_page = 10

  before_save :calculate_order_amount

  private

  def calculate_order_amount
    order_items_total = order_items.collect(&:total).sum

    self.booking.amount = 0 - order_items_total
  end
end
