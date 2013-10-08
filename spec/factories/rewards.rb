FactoryGirl.define do
  factory :reward do
    sequence(:name) { |n| "name#{n}" }
    association :creator, :factory => :coach
  end
end
