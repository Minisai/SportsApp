class Player < ActiveRecord::Base
  validates :coach, :presence => true

  has_one :user, :as => :role
  belongs_to :coach
  belongs_to :parent
end
