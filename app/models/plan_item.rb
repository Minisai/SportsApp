class PlanItem < ActiveRecord::Base
  validates :item, :presence => true

  belongs_to :item, :polymorphic => true
end
