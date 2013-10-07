class Drill < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :exercises, :dependent => :destroy
end
