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
  belongs_to  :order
  belongs_to  :delivery
  delegate    :user, to: :order

  validates :amount, presence: true, numericality: true

  before_validation :validate_order_item_amount
  before_save :update_order_amount

  private

  def validate_order_item_amount
    raise NotEnoughInventory if amount > delivery.remaining
  end

  def update_order_amount
    self.order.update_amount self.amount.to_f * self.delivery.unit_price.to_f
  end
end

class OrderItem::NotEnoughInventory < StandardError ; end
