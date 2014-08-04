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

  def update_amount(amount)
    self.booking.amount -= amount
    self.booking.save!
  end

  private

  def calculate_order_amount
    order_item_prices = self.order_items.collect do |order_item|
      order_item.amount.to_f * order_item.delivery.unit_price.to_f
    end

    self.booking.amount = 0 - order_item_prices.sum
  end
end
