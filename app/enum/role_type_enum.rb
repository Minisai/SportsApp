module RoleTypeEnum
  extend Enumerize

  enumerize :role_type, :in => {:player => 0, :coach => 1, :parent => 2}, :default => :player,
            :scope => true, :predicates => {:prefix => true}
end