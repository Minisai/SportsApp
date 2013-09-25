class Invitation < ActiveRecord::Base
  extend Enumerize
  validates :player, :coach, :status, :presence => true
  validates :player_id, :uniqueness => { :scope => :coach_id }

  belongs_to :player
  belongs_to :coach

  enumerize :status, :in => {:pending => 0, :accepted => 1, :declined => 2},
            :default => :pending, :scope => true, :predicates => true

  after_create :send_invitation_email

  def send_invitation_email
    if player.try(:user).present? && coach.try(:user).present?
      PlayerMailer.invite(player, coach).deliver
    end
  end
end
