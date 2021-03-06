class Plan < ActiveRecord::Base
  include MayBeDefaultConcern
  validates :name, :presence => true, :uniqueness => true

  belongs_to :creator, :polymorphic => true
  has_many :plan_items, -> { order('position ASC') }, :dependent => :destroy
  has_many :assignee_plans, :dependent => :destroy
  has_many :assignees, :through => :assignee_plans
  has_many :players, :through => :assignee_plans, :source => :assignee, :source_type => 'Player'
  has_many :teams, :through => :assignee_plans, :source => :assignee, :source_type => 'Team'
  has_many :plan_sessions, :through => :plan_items, :source => :item, :source_type => 'PlanSession'
  has_many :assessments, :through => :plan_items, :source => :item, :source_type => 'Assessment'
  has_many :rewards, :through => :plan_items, :source => :item, :source_type => 'Reward'

  accepts_nested_attributes_for :plan_items
end
