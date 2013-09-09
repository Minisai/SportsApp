class Payment < ActiveRecord::Base
  validates :pricing_plan, :user, :presence => true

  belongs_to :pricing_plan
  belongs_to :user
end
