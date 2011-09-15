class Organization < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_and_belongs_to_many :client_apps
  
  validates :name, :presence => true,
                   :uniqueness => true
end
