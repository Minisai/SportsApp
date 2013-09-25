class Player < ActiveRecord::Base
  include RoleConcern

  belongs_to :parent

  has_many :motivation_players
  has_many :motivations, :through => :motivation_players

  has_and_belongs_to_many :coaches, -> { uniq }
  has_and_belongs_to_many :teams, -> { uniq }

  delegate :last_sign_in_at, :to => :user

  scope :with_team, -> (team_id) { joins('left join players_teams on players.id = players_teams.player_id').where('players_teams.team_id = ?', team_id) }

  self.per_page = 10

  attr_reader :program_code

  before_save :add_coach_from_program_code

  def program_code=(new_program_code)
    @program_code = new_program_code.present? ? new_program_code : 'blank'
  end

  class << self
    def search(filter_params = {})
      players = all
      players = players.where(:id => filter_params[:player_id]) if filter_params[:player_id].present?
      players = players.joins(:user).where("users.last_name like ?", "%#{filter_params[:last_name]}%") if filter_params[:last_name].present?
      players = players.joins(:user).where("users.country like ?", "%#{filter_params[:country]}%") if filter_params[:country].present?
      players
    end
  end

  private
  def add_coach_from_program_code
    return if self.program_code.blank?
    new_coach = Coach.find_by_program_code(self.program_code) unless self.program_code == 'blank'
    if new_coach.present?
      coaches << new_coach
    elsif user.present?
      user.errors.add(:program_code, "Invalid program code")
      false
    end
  end
end
