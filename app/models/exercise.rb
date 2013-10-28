class Exercise < ActiveRecord::Base
  validates :drill, :suite, :presence => true

  belongs_to :drill
  belongs_to :suite, :polymorphic => true, :inverse_of => :exercises

  delegate :name, :to => :drill
end
