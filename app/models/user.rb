class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  validates :username, :name, :birthday, :country, :role, :presence => true
  validates :male, :inclusion => {:in => [true, false]}
  validates :username, :uniqueness => true

  belongs_to :role, :polymorphic => true, :inverse_of => :user

  attr_accessor :gender

  ROLE_TYPES = ['Player', 'Coach', 'Parent']

  def gender=(value)
    if ['male', 'female'].include?(value.downcase)
      self.male = value.downcase == 'male'
    end
  end

  def gender
    self.male ? 'Male' : "Female"
  end
end
