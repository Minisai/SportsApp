class Admin < ActiveRecord::Base
  include RoleConcern
  include CreatorConcern
end
