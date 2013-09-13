FactoryGirl.define do
  factory :coach do
    after(:create) do |coach|
      create(:user, :role => coach)
    end
  end
end
