class Coach < ActiveRecord::Base
  include RoleConcern

  validates :program_code, :uniqueness => true, :allow_blank => true

  has_many :teams
  has_many :motivations, :dependent => :destroy

  has_and_belongs_to_many :players

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
end
