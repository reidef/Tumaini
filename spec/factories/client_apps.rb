# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client_app do
    sequence(:name)  {|n| "My #{n} App" }
    api_key "randomAPIkey"
  end
end