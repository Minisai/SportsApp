class Assessment < ActiveRecord::Base
  validates :name, :coach, :presence => true
  validates :name, :uniqueness => {:scope => :coach_id}

  belongs_to :coach
  has_many :exercises, :dependent => :destroy
  has_many :drills, :through => :exercises

  accepts_nested_attributes_for :exercises
end