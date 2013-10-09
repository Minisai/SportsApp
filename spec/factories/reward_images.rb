FactoryGirl.define do
  factory :reward_image do
    image File.open(Rails.root.join('spec/factories/files/reward_image/valid.png'))
    association :creator, :factory => :coach
  end
end
