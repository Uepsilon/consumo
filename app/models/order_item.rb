# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  amount      :integer
#  order_id    :integer          not null
#  delivery_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :delivery
  delegate :user, to: :order
  delegate :booking, to: :order

  validates :amount, presence: true, numericality: true

  before_validation :validate_order_item_amount
  before_save :update_order_amount

  scope :by_realm, -> (current_realm_id) { joins(order: :booking).where('bookings.realm_id = ?', current_realm_id) }

  private

  def validate_order_item_amount
    fail NotEnoughInventory if amount > delivery.remaining
  end

  def total
    amount * delivery.unit_price
  end

  def update_order_amount
    booking.update_amount total
  end
end

class OrderItem::NotEnoughInventory < StandardError; end
