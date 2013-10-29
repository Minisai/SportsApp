class Plan < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  belongs_to :coach
  has_many :plan_items

  accepts_nested_attributes_for :plan_items
end
