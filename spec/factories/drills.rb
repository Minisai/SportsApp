FactoryGirl.define do
  factory :drill do
    sequence(:name) {|n| "Drill#{n}"}
  end
end
