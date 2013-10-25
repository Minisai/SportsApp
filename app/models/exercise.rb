class Exercise < ActiveRecord::Base
  validates :drill, :presence => true

  belongs_to :drill
  belongs_to :suite, :polymorphic => true

  delegate :name, :to => :drill
end
