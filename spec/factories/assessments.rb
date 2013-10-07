FactoryGirl.define do
  factory :assessment do
    sequence(:name) { |n| "name#{n}" }
    coach
  end
end
