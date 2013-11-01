class TeamWithPlansSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :plans
end