class AssigneePlan < ActiveRecord::Base
  validates :assignee, :plan, :presence => true

  belongs_to :assignee, :polymorphic => true
  belongs_to :plan
end
