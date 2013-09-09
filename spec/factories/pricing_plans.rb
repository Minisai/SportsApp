FactoryGirl.define do
  factory :pricing_plan do
    sequence(:name) {|n| "Plan #{n}"}
    role_type :coach
    cost 10
    duration 1

    factory(:pricing_plan_for_coach) { role_type :player }
    factory(:pricing_plan_for_player) { role_type :player }
    factory(:pricing_plan_for_parent) { role_type :parent }
  end
end
