# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client_app do
    sequence :name do |n|
      "My #{n} App"
    end
  end
end