class Day < ActiveRecord::Base
  validates :plan_session, :presence => true

  belongs_to :plan_session
  has_many :exercises, :as => :suite, :dependent => :destroy
end
