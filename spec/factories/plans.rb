FactoryGirl.define do
  factory :plan do
    sequence(:name) { |n| "name#{n}" }
    association :creator, :factory => :coach
    trait :with_plan_items do
      after(:create) do |plan|
        create_list(:plan_session_plan_item, 3, :with_days, :plan => plan)
        create(:reward_plan_item, :plan => plan, :item => create(:reward, :creator => plan.creator))
        create(:assessment_plan_item, :plan => plan, :item => create(:assessment, :creator => plan.creator))
      end
    end
  end
end
