# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)      default(""), not null
#  encrypted_password :string(255)      default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  first_name         :string(255)
#  last_name          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  current_realm_id   :integer
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email, email: true

  belongs_to :current_realm, class_name: 'Realm'

  has_many :bookings
  has_many :orders,      through: :bookings, source: :bookable, source_type: 'Order'
  has_many :deliveries,  through: :bookings, source: :bookable, source_type: 'Delivery'
  has_many :order_items, through: :orders

  def name
    "#{first_name} #{last_name}"
  end

  def ordered_products(current_realm_id)
    products = Hash.new do |hash, key|
      hash[key.delivery.product_id] = { amount: 0, product_title: key.delivery.product.title }
    end

    order_items.by_realm(current_realm_id).each do |item|
      products[item][:amount] += item.amount
    end
    products
  end

  def balance(current_realm_id)
    bookings.by_realm(current_realm_id).sum(:amount)
  end

  def todays_calories
    order_items.by_realm(current_realm_id).today.map { |item| item.delivery.product.calories }.sum
  end

  def last_ordered_product
    return I18n.t('order_item.last_order_empty') unless orders.by_realm(current_realm_id).present?
    last_order = orders.by_realm(current_realm_id).order(created_at: :desc).first
    last_order.order_items.order('RANDOM()').first.delivery.product.title
  end

  def last_delivery
    return I18n.t('order_item.last_delivery_empty') unless deliveries.by_realm(current_realm_id).present?
    deliveries.by_realm(current_realm_id).order(created_at: :desc).first.product.title
  end
end
