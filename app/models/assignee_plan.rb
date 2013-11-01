class AssigneePlan < ActiveRecord::Base
  validates :assignee, :plan, :presence => true
  validates :plan_id, :uniqueness => { :scope => [:assignee_type, :assignee_id] }

  belongs_to :assignee, :polymorphic => true
  belongs_to :plan
end
