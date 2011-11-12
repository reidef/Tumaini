class ClientApp < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  has_and_belongs_to_many :users
  
  validates :name, :presence => true,
                   :uniqueness => true
  validates :api_key, :presence => true
end
