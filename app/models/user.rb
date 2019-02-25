class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:userid]
  has_many :charges
  has_many :uploads
  has_many :cashflows

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :userid
  validates_uniqueness_of :userid
  validates_presence_of :stdnum
  validates_uniqueness_of :stdnum
  validates_presence_of :phonenum
  validates_presence_of :username

  
  
         
  def email_required?
   false
  end

  def email_changed?
  	false
  end

  def will_save_change_to_email?
  	false
  end
end
