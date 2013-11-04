class Assessment < ActiveRecord::Base
  include MayBeDefaultConcern

  validates :name, :creator, :presence => true
  validates :name, :uniqueness => {:scope => [:creator_id, :creator_type]}

  belongs_to :creator, :polymorphic => true
  has_many :exercises, :as => :suite, :inverse_of => :suite, :dependent => :destroy
  has_many :drills, :through => :exercises
  has_many :plan_items, :as => :item

  accepts_nested_attributes_for :exercises
end