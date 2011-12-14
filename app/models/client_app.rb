class ClientApp < ActiveRecord::Base
  include TokenGenerator
  
  attr_accessible :name, :callback_url, :app_url
  
  has_and_belongs_to_many :organizations
  has_and_belongs_to_many :users
  
  validates :name, :presence => true,
                   :uniqueness => true
  
  before_create { generate_token(:api_key) }
end
