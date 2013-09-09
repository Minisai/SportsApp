class PricingPlan < ActiveRecord::Base
  validates :name, :role_type, :cost, :duration, :presence => true
  validates :name, :presence => {:scope => :role_type}

  include RoleTypeEnum
end
