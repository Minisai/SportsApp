FactoryGirl.define do
  factory :plan do
    sequence(:name) { |n| "name#{n}" }
    coach
  end
end
