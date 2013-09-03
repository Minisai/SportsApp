class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case
      when user.coach?
        can :manage, Coach, :id => user.role.id
        can :manage, Player, :coach_id => user.role.id
    end

  end
end
