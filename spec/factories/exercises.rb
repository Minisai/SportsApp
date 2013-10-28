FactoryGirl.define do
  factory :exercise do
    drill
    repetitions 10
    association :suite, :factory => :assessment

    factory :day_exercise do
      association :suite, :factory => :day
    end

    factory :assessment_exercise do
      association :suite, :factory => :assessment
    end
  end
end
