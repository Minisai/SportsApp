class PlanSession < ActiveRecord::Base
  has_many :days
  has_many :plan_items, :as => :item

  accepts_nested_attributes_for :days
end
