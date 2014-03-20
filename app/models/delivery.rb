# == Schema Information
#
# Table name: deliveries
#
#  id         :integer          not null, primary key
#  product_id :integer          not null
#  quantity   :integer          not null
#  unit_price :decimal(5, 2)
#  created_at :datetime
#  updated_at :datetime
#

class Delivery < ActiveRecord::Base
  belongs_to  :product

  has_one     :booking,  as: :bookable,     dependent: :destroy
  has_one     :user,     through: :booking

  has_many    :order_items
  has_many    :orders,  through: :order_items

  validates   :product_id, presence: true
  validates   :quantity, presence: true, numericality: true
  validates   :price, presence: true, numericality: true

  before_save :calculate_booking_amount
  before_save :calculate_unit_price

  attr_accessor :price

  def remaining
    quantity - self.orders.sum(:amount)
  end

  private

  def calculate_unit_price
    self.unit_price = self.price.to_f / self.quantity.to_f
  end

  def calculate_booking_amount
    self.booking.amount = self.price.to_f
  end
end
