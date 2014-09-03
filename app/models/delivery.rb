# == Schema Information
#
# Table name: deliveries
#
#  id         :integer          not null, primary key
#  product_id :integer          not null
#  quantity   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  price      :decimal(7, 2)
#  realm_id   :integer
#

class Delivery < ActiveRecord::Base
  belongs_to  :product

  has_one     :booking,  as: :bookable,       dependent: :destroy
  belongs_to  :realm

  has_many    :order_items, dependent: :destroy
  has_many    :orders,  through: :order_items, dependent: :destroy

  delegate    :user, to: :booking

  validates   :product_id, presence: true
  validates   :quantity, presence: true, numericality: true
  validates   :price, presence: true, numericality: true
  validates   :realm, presence: true

  before_validation :ensure_realm
  scope :current_realm, -> (realm_id) { where(realm_id: realm_id) }

  self.per_page = 10

  def remaining
    quantity - self.orders.sum(:amount)
  end

  def unit_price
    price.to_f / quantity
  end

  private

  def ensure_realm
    self.realm = self.user.current_realm unless self.realm.present?
  end
end
