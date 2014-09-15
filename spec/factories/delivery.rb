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

FactoryGirl.define do
  factory :delivery do
    product
    quantity 5
    price 5.55
    realm
  end
end