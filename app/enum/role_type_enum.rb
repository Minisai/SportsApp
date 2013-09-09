module RoleTypeEnum
  extend Enumerize

  enumerize :role_type, in: %w[male female]
end