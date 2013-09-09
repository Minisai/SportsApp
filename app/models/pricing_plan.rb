class PricingPlan < ActiveRecord::Base
  validates :name, :role_type, :cost, :duration, :presence => true
  validates :name, :presence => {:scope => :role_type}

  has_many :payments

  include RoleTypeEnum
end
