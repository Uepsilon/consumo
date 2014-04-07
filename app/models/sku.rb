class Sku < ActiveRecord::Base
  has_many :products

  validates :title, presence: true
  validates :short, presence: true
end
