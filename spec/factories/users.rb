FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@mail.com"}
    sequence(:username) {|n| "user#{n}"}
    password "password1234"
    name "user"
    birthday Date.today
    country "Belarus"
    male true

    factory(:player_user) { association :role, :factory => :player }
    factory(:parent_user) { association :role, :factory => :parent }
    factory(:coach_user) { association :role, :factory => :coach }
  end
end
