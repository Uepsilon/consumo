# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  amount        :decimal(5, 2)    not null
#  bookable_id   :integer
#  bookable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  infotext      :string(255)
#  booking_id    :integer
#  realm_id      :integer
#

class Booking < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :realm
  belongs_to  :bookable, polymorphic: true

  has_one     :related_booking, class_name: "Booking", foreign_key: :booking_id, dependent: :destroy
  belongs_to  :initial_booking, class_name: "Booking", foreign_key: :booking_id

  scope :current_realm, -> (realm_id) { where(realm_id: realm_id) }

  validates :amount, presence: true, numericality: true

  attr_accessor :receiver_id

  before_create :relate_booking, if: :booking_relation
  before_create :ensure_realm

  self.per_page = 10

  def update_amount(amount)
    update amount: self.amount - amount
  end

  def booking_relation
    receiver_id.present?
  end

  private

  def ensure_realm
    self.realm = user.current_realm unless realm.present?
  end

  def relate_booking
    build_related_booking user: User.find(receiver_id), amount: (amount * -1), infotext: infotext
  end
end
