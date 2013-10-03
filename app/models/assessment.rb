class Assessment < ActiveRecord::Base
  validates :name, :coach, :presence => true
  validates :name, :uniqueness => true

  belongs_to :coach
  has_many :exercises, :dependent => :destroy
  has_many :drills, :through => :exercises
end
