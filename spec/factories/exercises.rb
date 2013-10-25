FactoryGirl.define do
  factory :exercise do
    drill
    repetitions 10
    association :suite, :factory => :assessment
  end
end
