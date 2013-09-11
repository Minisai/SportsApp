class CoachMailer < BaseMailer
  def program_code(coach)
    @coach = coach
    mail(:to => @coach.email, :subject => "Program code for #{@coach.name}")
  end
end
