FactoryGirl.define do
  factory :assessment do
    sequence(:name) { |n| "name#{n}" }
    association :creator, :factory => :coach
  end
end
