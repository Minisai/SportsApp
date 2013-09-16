class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :coach_id, :parent_id, :name, :email, :country
end
