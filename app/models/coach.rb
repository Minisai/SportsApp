class Coach < ActiveRecord::Base
  include RoleConcern

  validates :program_code, :uniqueness => true, :allow_blank => true

  has_many :teams
  has_many :motivations, :dependent => :destroy
  has_many :invitations, :dependent => :destroy

  has_and_belongs_to_many :players, -> { uniq }

  def find_or_create_motivation(motivation_params)
    if motivation_params[:id] == 'new'
      motivations.find_or_create_by(:message => motivation_params[:message])
    else
      motivations.find_by_id(motivation_params[:id])
    end
  end

  def generate_program_code
    while true do
      generated_code = "PROGR_#{SecureRandom.hex(3)}"
      if Coach.find_by_program_code(generated_code).blank?
        self.update_attribute(:program_code, generated_code)
        CoachMailer.program_code(self).deliver
        break
      end
    end
  end


  #RRREFACTOR THIS SHIT!!!
  def invite_player_with(invitation_params)
    user_with_provided_email = User.find_by_email(invitation_params[:email])
    if user_with_provided_email.try(:coach?) || user_with_provided_email.try(:parent?)
      return {:success => false, :message => "Coach or parent has been already registered with this email"}
    end

    invited_player = user_with_provided_email.try(:role) || self.players.create(:user_attributes => invitation_params, :invited => true)

    if invited_player.persisted?
      invitation = self.invitations.create(:player => invited_player)
      if invitation.persisted?
        {:success => true}
      else
        {:success => false, :message => invitation.errors.full_messages.join(' ')}
      end
    else
      {:success => false, :message => invited_player.errors.full_messages.join(' ')}
    end
  end
end
