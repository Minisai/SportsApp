# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    association :user, :factory => :player_user
    association :pricing_plan, :factory => :pricing_plan_for_player
  end
end
