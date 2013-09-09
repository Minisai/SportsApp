FactoryGirl.define do
  factory :payment do
    association :user, :factory => :player_user
    association :pricing_plan, :factory => :pricing_plan_for_player
  end
end
