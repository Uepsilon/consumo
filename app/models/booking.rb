# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  amount        :decimal(5, 2)
#  bookable_id   :integer
#  bookable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Booking < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :bookable, polymorphic: true

  validates :amount, presence: true, numericality: true

  default_scope order("created_at DESC")
end
