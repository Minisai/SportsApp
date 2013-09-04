class PlayerMailer < BaseMailer
  def email_message(player, message)
    @player = player
    @message = message
    mail(:to => @player.email, :subject => "Message from #{@player.coach.name}")
  end

  def motivation(player, motivation)
    @player = player
    @motivation_message = motivation.message
    mail(:to => @player.email, :subject => "Motivation from #{@player.coach.name}")
  end
end
