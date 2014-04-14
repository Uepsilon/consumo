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
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  # validates :first_name,  presence: true
  # validates :last_name,   presence: true
  # validates :email,       email: true

  has_many  :bookings
  has_many  :orders,      through: :bookings, source: :bookable, source_type: "Order"
  has_many  :deliveries,  through: :bookings, source: :bookable, source_type: "Delivery"
  has_many  :order_items, through: :orders

  def name
    "#{first_name} #{last_name}"
  end

  def ordered_products
    products = {}
    self.order_items.each do |oi|
      products[oi.delivery.product.id] = {amount: 0, product_title: oi.delivery.product.title} unless products[oi.delivery.product.id].is_a? Hash
      products[oi.delivery.product.id][:amount] += oi.amount
    end
    products
  end

  def balance
    self.bookings.sum(:amount)
  end
end
