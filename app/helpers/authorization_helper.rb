module AuthorizationHelper

  def player_signed_in?
    current_user.try(:player?)
  end

  def coach_signed_in?
    current_user.try(:coach?)
  end

  def parent_signed_in?
    current_user.try(:parent?)
  end
end