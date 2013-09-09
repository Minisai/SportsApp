module RoleTypeEnum
  extend Enumerize

  enumerize :role_type, :in => [:player, :coach, :parent], :default => :player
end