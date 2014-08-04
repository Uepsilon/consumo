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
#  category_id          :integer
#  sku_id               :integer
#  calories             :integer          default(0)
#

class Product < ActiveRecord::Base

  if Rails.env.production?
    has_attached_file :picture,
      storage: :s3,
      s3_credentials:  {
        bucket:  ENV['DB_S3_BUCKET'],
        access_key_id:  ENV['DB_S3_ID'],
        secret_access_key:  ENV['DB_S3_KEY']
      },
      path:  "/images/:rails_env/products/:id/:style.:extension",
      url:  ":s3_domain_url",
      styles:  { medium:  "200x200>", thumb:  "100x100>" }
  else
    has_attached_file :picture,
      styles:  { medium:  "200x200>", thumb:  "100x100>" }
  end

  belongs_to :category
  belongs_to :sku
  has_many :deliveries

  scope :current_realm, -> (realm_id) { joins(:deliveries).where('deliveries.realm_id = ?', realm_id) }

  self.per_page = 10

  validates_attachment_presence     :picture
  validates_attachment_content_type :picture, content_type:  /\Aimage\/.*\Z/

  validates :name,    presence: true
  validates :size,    presence: true, numericality: true
  validates :calories,  presence: true, numericality: true

  def title
    "#{name} (#{size.to_s.gsub!('.', ',')}#{sku.short})"
  end

  def size_with_unit
    "#{size} #{sku.short}"
  end

  def remaining(realm_id)
    self.deliveries.current_realm(realm_id).collect{|d| d.remaining}.sum
  end

  def current_delivery(realm_id)
    self.deliveries.current_realm(realm_id).order(:created_at).each do |delivery|
      return delivery if delivery.remaining > 0
    end
  end
end
