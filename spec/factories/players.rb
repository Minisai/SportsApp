FactoryGirl.define do
  factory :player do
    coach
    team
    after(:create) do |player|
      create(:user, :role => player)
    end
  end
end
