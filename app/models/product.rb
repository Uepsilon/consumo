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
#

class Product < ActiveRecord::Base

  has_attached_file :picture, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/pictures/:style/missing.png"

  has_many  :deliveries

  validates_attachment_presence     :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  validates :name,    presence: true
  validates :size,    presence: true, numericality: true

  def title
    "#{name} (#{size.to_s.gsub!('.', ',')}l)"
  end

  def remaining
    self.deliveries.each.collect{|d| d.remaining}.sum
  end

  def current_delivery_id
    self.deliveries.order(:created_at).each do |delivery|
      return delivery.id unless delivery.remaining.zero?
    end
  end
end
