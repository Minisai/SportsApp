default_coach = Coach.create do |coach|
  coach.program_code = "PROG123"
  coach.user_attributes = {
    :email => "coach@mail.com",
    :name => "coach",
    :username => "coachuser",
    :password => "coach@mail.com",
    :birthday => 20.years.ago,
    :country => 'Bealrus',
    :male => true
  }
end

default_team = Team.create do |team|
  team.coach = default_coach
  team.name = 'Garden City Panthers'
end

default_parent = Parent.create do |coach|
  coach.user_attributes = {
    :email => "parent@mail.com",
    :name => "parent",
    :username => "parentuser",
    :password => "parent@mail.com",
    :birthday => 40.years.ago,
    :country => 'Belarus',
    :male => true
  }
end

20.times do |i|
  Player.create do |player|
    player.coach = default_coach
    player.team = default_team
    player.parent = default_parent
    player.user_attributes = {
      :email => "player#{i}@mail.com",
      :name => "player#{i}",
      :username => "playeruser#{i}",
      :password => "player#{i}@mail.com",
      :birthday => 10.years.ago,
      :country => 'Belarus',
      :male => true
    }
  end
end

20.times do |i|
  Motivation.create do |motivation|
    motivation.coach = default_coach
    motivation.message = "Motivation message #{i}"
  end
end