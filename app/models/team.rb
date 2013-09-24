class Team < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :coach, :presence => true

  has_many :players
  belongs_to :coach

  has_and_belongs_to_many :players
end
