class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  has_secure_password
  
  validates_presence_of :password, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
  validates :email, :presence => true,
                    :uniqueness => true,
                    :email_format => true
end
