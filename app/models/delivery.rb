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

  has_one     :booking,  as: :bookable,       dependent: :destroy
  has_one     :user,     through: :booking
  belongs_to  :realm

  has_many    :order_items, dependent: :destroy
  has_many    :orders,  through: :order_items, dependent: :destroy

  validates   :product_id, presence: true
  validates   :quantity, presence: true, numericality: true
  validates   :price, presence: true, numericality: true
  validates   :realm, presence: true

  scope :current_realm, -> (realm_id) { where(realm_id: realm_id) }

  self.per_page = 10

  def remaining
    quantity - self.orders.sum(:amount)
  end

  def unit_price
    price.to_f / quantity
  end
end
