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

FactoryGirl.define do
  factory :user do
    first_name 'Chuck'
    last_name 'Norris'
    sequence(:email) {|i| "testacc#{i}@i22.de"}
    password 'Test1234'
  end
end