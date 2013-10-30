FactoryGirl.define do
  factory :plan do
    sequence(:name) { |n| "name#{n}" }
    coach
    trait :with_plan_items do
      after(:create) do |plan|
        create_list(:plan_session_plan_item, 3, :with_days, :plan => plan)
        create(:reward_plan_item, :plan => plan, :item => create(:reward, :creator => plan.coach))
        create(:assessment_plan_item, :plan => plan, :item => create(:assessment, :coach => plan.coach))
      end
    end
  end
end
