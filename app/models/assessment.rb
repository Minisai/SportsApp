class Assessment < ActiveRecord::Base
  validates :name, :coach, :presence => true
  validates :name, :uniqueness => {:scope => :coach_id}

  belongs_to :coach
  has_many :exercises, :as => :suite, :inverse_of => :suite, :dependent => :destroy
  has_many :drills, :through => :exercises
  has_many :plan_items, :as => :item

  accepts_nested_attributes_for :exercises
end