class Day < ActiveRecord::Base
  has_many :exercises, :as => :suite, :dependent => :destroy
end
