class PlayerMailer < BaseMailer
  def email_message(player, coach, message)
    @player = player
    @coach = coach
    @message = message
    mail(:to => @player.email, :subject => "Message from #{@coach.name}")
  end

  def motivation(player, coach, motivation)
    @player = player
    @coach = coach
    @motivation_message = motivation.message
    mail(:to => @player.email, :subject => "Motivation from #{@coach.name}")
  end

  def invite(player, coach)
    @player = player
    @coach = coach
    mail(:to => @player.email, :subject => "Invitation from #{@coach.name}")
  end
end
