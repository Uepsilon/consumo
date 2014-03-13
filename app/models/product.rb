class Product < ActiveRecord::Base

  has_attached_file :brandpicture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/brandpictures/:style/missing.png"
  validates_attachment_content_type :brandpicture, :content_type => /\Aimage\/.*\Z/

  validates :name,    presence: true
  validates :amount,  presence: true, numericality: true
  validates :price,   presence: true, numericality: true
end
