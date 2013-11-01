FactoryGirl.define do
  factory :assessment do
    sequence(:name) { |n| "Assessment #{n}" }
    sequence(:description) { |n| "Assessment #{n}" }
    association :creator, :factory => :coach
  end
end
