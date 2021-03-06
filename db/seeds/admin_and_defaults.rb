['Throw and Catch', 'Bounce & Catch', 'Ground Balls To', 'Ground Balls Away',
 'Throw & Cradle', 'Quickstick', 'One hand', 'Throw and Shoot', 'Jump',
 'Hand on your hips!', 'Hand on your knees!', 'Hand up!', 'Jump up high',
 'Turn around', 'Stand up and jump!', 'Stand on your left leg', 'Stand on your right'].each do |name|
  Drill.create do |drill|
    drill.name = name
    drill.description = name
  end
end

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

#create default reward_images
unless RewardImage.any?
  Dir.foreach(Rails.root.join('db/seeds/images')) do |file_path|
    RewardImage.create do |reward_image|
      reward_image.image = File.open(Rails.root.join("db/seeds/images/#{file_path}"))
      reward_image.creator = default_admin
    end
  end
end

#create default rewards
RewardImage.where(:creator_type => 'Admin').each_with_index do |reward_image, index|
  default_admin.rewards.create do |reward|
    reward.name = "Reward #{index}"
    reward.description = 'This reward was generated by default'
    reward.reward_image = reward_image
  end
end

#create custom coach rewards
default_coach = User.find_by_email("coach@mail.com").try(:role)

if default_coach.present?
  RewardImage.where(:creator_type => 'Admin').each_with_index do |reward_image, index|
    default_coach.rewards.create do |reward|
      reward.name = "Custom Reward #{index}"
      reward.description = "This is custom reward #{index}"
      reward.reward_image = reward_image
    end
  end
end

#create default assessments
5.times do |i|
  assessment = Assessment.create do |assessment|
    assessment.creator = default_admin
    assessment.name = "Assessment #{i}"
    assessment.description = 'This assessment was generated by default'
  end
  ['Throw and Catch', 'Bounce & Catch', 'Ground Balls To', 'Stand on your right'].each do |name|
    Exercise.create do |exercise|
      exercise.drill = Drill.find_by_name(name)
      exercise.repetitions = i
      exercise.suite = assessment
    end
  end
end

#create default plans
5.times do |plan_count|
  plan = Plan.create do |plan|
    plan.creator = default_admin
    plan.name = "Default Plan #{plan_count}"
    plan.description = 'This plan was generated by default'
  end

  # Add 2 Sessions
  2.times do |session_count|
    plan_session = PlanSession.create

    # With 3 Days each
    3.times do |day_count|
      day = plan_session.days.create
      ['Throw and Catch', 'Bounce & Catch', 'Ground Balls To', 'Stand on your right'].each do |name|
        Exercise.create do |exercise|
          exercise.drill = Drill.find_by_name(name)
          exercise.repetitions = day_count + 1
          exercise.suite = day
        end
      end
    end
    PlanItem.create do |plan_item|
      plan_item.item = plan_session
      plan_item.position = session_count
      plan_item.plan = plan
    end
  end

  #Add Assessment
  PlanItem.create do |plan_item|
    plan_item.item = Assessment.find_by_name("Assessment #{plan_count}")
    plan_item.position = 2
    plan_item.plan = plan
  end

  #Add Reward
  PlanItem.create do |plan_item|
    plan_item.item = Reward.find_by_name("Reward #{plan_count}")
    plan_item.position = 3
    plan_item.plan = plan
  end
end