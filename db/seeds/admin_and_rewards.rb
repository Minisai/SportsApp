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

unless RewardImage.any?
  Dir.foreach(Rails.root.join('db/seeds/images')) do |file_path|
    RewardImage.create do |reward_image|
      reward_image.image = File.open(Rails.root.join("db/seeds/images/#{file_path}"))
      reward_image.creator = default_admin
    end
  end
end

RewardImage.where(:creator_type => 'Admin').each_with_index do |reward_image, index|
  default_admin.rewards.create do |reward|
    reward.name = "Reward #{index}"
    reward.description = "This is reward #{index}"
    reward.reward_image = reward_image
  end
end

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