class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_url, :reward_image_id
end
