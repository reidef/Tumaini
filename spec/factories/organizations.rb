# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
      sequence(:name) { |n| "Organization#{n}" }
    end
end