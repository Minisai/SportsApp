FactoryGirl.define do
  factory :plan_item do
    association :item, :factory => :plan_session

    factory :plan_session_plan_item do
      association :item, :factory => :plan_session
      trait :with_days do
        after(:create) do |plan_item|
          create_list(:day, 2, :with_exercises, :plan_session => plan_item.item)
        end
      end
    end

    factory :reward_plan_item do
      association :item, :factory => :reward
    end

    factory :assessment_plan_item do
      association :item, :factory => :assessment
    end
  end
end
