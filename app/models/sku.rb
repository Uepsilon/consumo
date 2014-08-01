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

class Sku < ActiveRecord::Base
  has_many :products

  validates :title, presence: true
  validates :short, presence: true
end
