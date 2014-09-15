# == Schema Information
#
# Table name: skus
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  short      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :sku do
    sequence(:title) {|i| "Test SKU #{i}"}
    sequence(:short) {|i| "sku#{i}"}
  end
end