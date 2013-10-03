class Exercise < ActiveRecord::Base
  validates :drill, :presence => true

  belongs_to :drill
  belongs_to :assessment
end
