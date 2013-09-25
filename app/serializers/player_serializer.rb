class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :coach_ids, :parent_id, :name, :email, :country, :invited
end
