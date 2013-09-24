class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case
      when user.coach?
        can :manage, Coach, :id => user.role.id
        can :manage, Motivation, :coach_id => user.role.id
        can :manage, Player do |player|
          player.coach_ids.include?(user.role.id)
        end
        can :invite, Player
        can :manage, :dashboard
        can :manage, Team, :coach_id => user.role.id
    end

  end
end
