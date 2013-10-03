class Exercise < ActiveRecord::Base
  validates :drill, :presence => true

  belongs_to :drill
end
