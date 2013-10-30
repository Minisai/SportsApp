FactoryGirl.define do
  factory :day do
    plan_session

    trait :with_exercises do
      after(:create) do |day|
        create_list(:exercise, 5, :suite => day)
      end
    end
  end
end
