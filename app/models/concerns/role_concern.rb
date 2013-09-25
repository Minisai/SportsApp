module RoleConcern
  extend ActiveSupport::Concern

  included do
    has_one :user, :as => :role, :dependent => :destroy, :inverse_of => :role
    accepts_nested_attributes_for :user
    delegate :name, :first_name, :last_name, :email, :country, :to => :user
  end
end