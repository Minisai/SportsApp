class Plan < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  belongs_to :creator, :polymorphic => true
  has_many :plan_items, :dependent => :destroy
  has_many :assignee_plans, :dependent => :destroy
  has_many :assignees, :through => :assignee_plans

  accepts_nested_attributes_for :plan_items

  scope :default, -> { where(:creator_type => 'Admin') }
end
