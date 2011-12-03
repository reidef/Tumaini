class User < ActiveRecord::Base
  include TokenGenerator
  
  attr_accessible :email, :password, :password_confirmation, :client_app_ids
  
  has_secure_password
  
  belongs_to :organization
  has_and_belongs_to_many :client_apps
  
  validates_presence_of :password, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
  validates :email, :presence => true,
                    :uniqueness => true,
                    :email_format => true
  
  before_create { generate_token(:auth_token) }
end
