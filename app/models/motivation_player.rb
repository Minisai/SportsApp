class MotivationPlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :motivation

  after_create :send_motivation_message

  def send_motivation_message
    PlayerMailer.motivation(player, self.motivation).deliver
  end
end
