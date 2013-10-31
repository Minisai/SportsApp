FactoryGirl.define do
  factory :reward do
    sequence(:name) { |n| "Reward #{n}" }
    sequence(:description) { |n| "Reward #{n}" }
    association :creator, :factory => :coach
  end
end
