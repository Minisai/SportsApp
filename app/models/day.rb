class Day < ActiveRecord::Base
  validates :plan_session, :presence => true

  belongs_to :plan_session
  has_many :exercises, :as => :suite, :inverse_of => :suite, :dependent => :destroy

  accepts_nested_attributes_for :exercises
end
