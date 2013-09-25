default_coach = User.find_by_email("coach@mail.com").try(:role) || Coach.create do |coach|
  coach.program_code = "PROG123"
  coach.user_attributes = {
    :email => "coach@mail.com",
    :first_name => "first_name",
    :last_name => 'last_name',
    :username => "coachuser",
    :password => "coach@mail.com",
    :birthday => 20.years.ago,
    :country => 'Bealrus',
    :male => true
  }
end

default_team = Team.find_by_name('Garden City Panthers') || Team.create do |team|
  team.coach = default_coach
  team.name = 'Garden City Panthers'
end

default_parent = User.find_by_email("parent@mail.com").try(:role) || Parent.create do |coach|
  coach.user_attributes = {
    :email => "parent@mail.com",
    :first_name => "first_name",
    :last_name => 'last_name',
    :username => "parentuser",
    :password => "parent@mail.com",
    :birthday => 40.years.ago,
    :country => 'Belarus',
    :male => true
  }
end

20.times do |i|
  new_player = Player.create do |player|
    player.parent = default_parent
    player.user_attributes = {
      :email => "player#{i}@mail.com",
      :first_name => "first#{i}",
      :last_name => "last#{i}",
      :username => "playeruser#{i}",
      :password => "player#{i}@mail.com",
      :birthday => 10.years.ago,
      :country => 'Belarus',
      :male => true
    }
  end

  default_coach.players << new_player
  default_team.players << new_player
end

20.times do |i|
  Motivation.create do |motivation|
    motivation.message = "Motivation message #{i}"
    motivation.coach = default_coach
  end
end

Dir[Rails.root.join('db/seeds/*.rb')].each {|f| load f }