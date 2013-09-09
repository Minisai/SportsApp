class PricingPlan < ActiveRecord::Base
  include RoleTypeEnum

  validates :name, :role_type, :cost, :duration, :presence => true
  validates :name, :presence => {:scope => :role_type}

  has_many :payments

  default_scope order('duration ASC')

  class << self
    def with_role_type_for(user)
      with_role_type(user.role_type.downcase.to_sym)
    end
  end
end
