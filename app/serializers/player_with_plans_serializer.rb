class PlayerWithPlansSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :country
  has_many :plans
end

