# == Schema Information
#
# Table name: products
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  size                 :decimal(5, 2)
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  category_id          :integer
#  sku_id               :integer
#  calories             :integer          default(0), not null
#

FactoryGirl.define do
  factory :product do
    sequence(:name) {|i| "Test Product #{i}"}
    size 33.33
    category
    sku
    calories 123
    picture Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'images', 'product', '01.jpg'), 'image/jpg')
  end
end