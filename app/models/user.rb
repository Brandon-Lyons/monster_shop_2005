class User < ApplicationRecord
  has_many :orders
  belongs_to :merchant, optional: true

  validates_presence_of :name, :address, :city, :state, :zip, :role

  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :password_confirmation, :presence => true, :confirmation => true, :on => :create

  validates :email, uniqueness: true, presence: true

  enum role: %w(regular merchant admin)

  has_secure_password

  def self.email_exists?(email)
    self.find_by(email:email) != nil
  end

  def has_orders?
    orders.exists?
  end
end
