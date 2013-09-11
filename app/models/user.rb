class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :trackable

  validates :username, :name, :birthday, :country, :role, :presence => true
  validates :male, :inclusion => {:in => [true, false]}
  validates :username, :uniqueness => true

  belongs_to :role, :polymorphic => true, :inverse_of => :user
  has_many :payments

  after_create :generate_program_code_if_coach

  attr_accessor :gender

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

  private
  def generate_program_code_if_coach
    if self.coach?
      self.role.generate_program_code
    end
  end
end
