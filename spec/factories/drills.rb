FactoryGirl.define do
  factory :drill do
    sequence(:name) {|n| "name#{n}"}
  end
end
