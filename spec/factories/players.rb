FactoryGirl.define do
  factory :player do
    program_code { create(:coach).program_code }
    after(:create) do |player|
      create(:user, :role => player)
    end
  end
end
