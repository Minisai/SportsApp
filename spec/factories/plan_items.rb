FactoryGirl.define do
  factory :plan_item do
    association :item, :factory => :plan_session

    factory :plan_session_plan_item do
      association :item, :factory => :plan_session
    end

    factory :reward_plan_item do
      association :item, :factory => :reward
    end

    factory :assessment_plan_item do
      association :item, :factory => :assessment
    end
  end
end
