class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :email,       email: true

  def username
    "#{first_name} #{last_name}"
  end
end
