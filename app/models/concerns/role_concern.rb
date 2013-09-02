module RoleConcern
  extend ActiveSupport::Concern

  included do
    has_one :user, :as => :role, :inverse_of => :role
    accepts_nested_attributes_for :user
  end
end