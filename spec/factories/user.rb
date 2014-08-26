FactoryGirl.define do
  factory :user do
    first_name 'Chuck'
    last_name 'Norris'
    sequence(:email) {|i| "testacc#{i}@i22.de"}
    password 'Test1234'
  end
end