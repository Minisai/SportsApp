FactoryGirl.define do
  factory :player do
    coach
    after(:create) do |player|
      create(:user, :role => player)
    end
  end
end
