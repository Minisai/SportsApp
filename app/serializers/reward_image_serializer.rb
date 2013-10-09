class RewardImageSerializer < ActiveModel::Serializer
  attributes :id, :image, :image_url, :rooted

  def rooted
    object.creator_type == 'Admin'
  end
end
