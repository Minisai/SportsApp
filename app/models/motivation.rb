class Motivation < ActiveRecord::Base
  validates :coach, :message, :presence => true
  validates :coach, :uniqueness => { :scope => :message }

  belongs_to :coach
  has_many :motivation_players
  has_many :players, :through => :motivation_players
end
