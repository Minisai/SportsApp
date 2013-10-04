class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :trackable

  validates :username, :first_name, :last_name, :birthday, :country, :role, :presence => true, :unless => :invited_player?
  validates :male, :inclusion => {:in => [true, false]}, :unless => :invited_player?
  validates :username, :uniqueness => true, :unless => :invited_player?

  belongs_to :role, :polymorphic => true
  has_many :payments

  after_create :generate_program_code_if_coach

  attr_accessor :gender
  attr_reader :name

  ROLE_TYPES = RoleTypeEnum.role_type.values.map(&:to_s)

  ROLE_TYPES.each do |role_name|
    define_method "#{role_name}?" do
      role_type == role_name.to_s.classify
    end
  end

  def gender=(value)
    if ['male', 'female'].include?(value.downcase)
      self.male = value.downcase == 'male'
    end
  end

  def gender
    self.male ? 'Male' : "Female"
  end

  def paid?
    self.expired_at.present? && self.expired_at >= Date.today
  end

  def name
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  def password_required?
    !invited_player?
  end

  private
  def generate_program_code_if_coach
    if self.coach?
      self.role.generate_program_code
    end
  end

  def invited_player?
    if role_type == 'Player'
      role.try(:invited?)
    end
  end
end
