class PlanSession < ActiveRecord::Base
  has_many :days
  has_many :plan_items, :as => :item
end
