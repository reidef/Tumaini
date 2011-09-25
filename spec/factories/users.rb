# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
      sequence :email do |n|
        "user#{n}@example.com"
      end
      password "secret"
      password_confirmation { password }
    end
end