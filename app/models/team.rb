class Team < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :coach, :presence => true

  belongs_to :coach

  has_and_belongs_to_many :players, -> { uniq }
  has_many :assignee_plans, :as => :assignee, :dependent => :destroy
  has_many :plans, :through => :assignee_plans

  self.per_page = 1
end
