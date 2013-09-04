class Motivation < ActiveRecord::Base
  validates :coach, :message, :presence => true
  validates :coach, :uniqueness => { :scope => :message }

  belongs_to :coach
  has_and_belongs_to_many :players
end
