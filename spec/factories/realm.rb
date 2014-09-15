# == Schema Information
#
# Table name: realms
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  active_flag :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :realm do
    sequence(:name) {|i| "Test Realm #{i}"}
    active_flag true
  end
end