default_admin = User.find_by_email("admin@mail.com").try(:role) || Admin.create do |admin|
  admin.user_attributes = {
      :email => "admin@mail.com",
      :first_name => "admin",
      :last_name => 'admin',
      :username => "admin",
      :password => "admin@mail.com",
      :birthday => 40.years.ago,
      :country => 'Belarus',
      :male => true
  }
end