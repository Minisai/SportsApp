class Player < ActiveRecord::Base
  include RoleConcern

  validates :coach, :presence => true

  belongs_to :coach
  belongs_to :parent
end
