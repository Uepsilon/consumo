# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  scope :by_position, -> { order('categories.position ASC') }
  scope :products_for_realm, -> (realm_id) {
    joins(products: {deliveries: :realm}).
    group('categories.id').
    where('realms.id = ?', realm_id)
  }

  has_many :products

  before_create :init_position

  validates :title, presence: true

  private

  def init_position
    self.position = 999 if self.position.nil?
  end
end
