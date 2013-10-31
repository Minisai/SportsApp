FactoryGirl.define do
  factory :drill do
    sequence(:name) {|n| "Drill #{n}"}
    sequence(:description) {|n| "Drill #{n}"}
  end
end
