class PlanSession < ActiveRecord::Base
  has_many :days, :inverse_of => :plan_session
  has_many :plan_items, :as => :item

  accepts_nested_attributes_for :days
end
