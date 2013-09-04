class Player < ActiveRecord::Base
  include RoleConcern

  validates :coach, :presence => true

  belongs_to :coach
  belongs_to :team
  belongs_to :parent
  has_and_belongs_to_many :motivations

  after_validation :add_program_code_error_to_user

  delegate :name, :email, :last_sign_in_at, :to => :user

  self.per_page = 10

  private
  def add_program_code_error_to_user
    if self.errors[:coach].present? && self.user.present?
      self.user.errors.add(:program_code, "Invalid program code")
    end
  end
end
