FactoryGirl.define do
  factory :assignee_plan do
    association :assignee, :factory => :player
    plan
  end
end
