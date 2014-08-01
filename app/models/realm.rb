# == Schema Information
#
# Table name: realms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Realm < ActiveRecord::Base
  has_many :bookings

  has_many :deliveries, through: :booking
  has_many :orders, through: :booking

  before_validation :slugify

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  private

  def slugify
    if slug.nil?
      slug = self.name.dup

      slug.gsub!(/[äöüß]/) do |match|
        case match
          when "ä" then 'ae'
          when "ö" then 'oe'
          when "ü" then 'ue'
          when "ß" then 'ss'
          else ''
        end
      end
      slug.gsub!(/\s/, '-')
      slug.gsub!(/[^\w-]/, '')
      slug.downcase!

      self.slug = slug
    end
  end
end
