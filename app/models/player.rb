class Player < ActiveRecord::Base
  include RoleConcern

  validates :coach, :presence => true

  belongs_to :coach
  belongs_to :team
  belongs_to :parent

  has_many :motivation_players
  has_many :motivations, :through => :motivation_players

  after_validation :add_program_code_error_to_user

  delegate :last_sign_in_at, :to => :user

  scope :with_team, -> (team_id) { where(:team_id => team_id) }

  self.per_page = 10

  class << self
    def search(filter_params = {})
      players = all
      players = players.where(:id => filter_params[:player_id]) if filter_params[:player_id].present?
      players = players.joins(:user).where("users.name like ?", "%#{filter_params[:name]}%") if filter_params[:name].present?
      players = players.joins(:user).where("users.country like ?", "%#{filter_params[:country]}%") if filter_params[:country].present?
      players
    end
  end

  private
  def add_program_code_error_to_user
    if self.errors[:coach].present? && self.user.present?
      self.user.errors.add(:program_code, "Invalid program code")
    end
  end
end
