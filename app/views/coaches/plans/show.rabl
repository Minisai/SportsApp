object @plan
attributes :id, :name, :description

child :plan_items, :object_root => false do
  attributes :id, :item_id, :item_type, :position
  child :item => :item do |item|
    attributes :id, :name, :description
    if item.is_a?(PlanSession)
      child :days, :object_root => false do
        attributes :id
        child :exercises, :object_root => false do
          attributes :id, :name, :repetitions
        end
      end
    elsif item.is_a?(Assessment)
      child :exercises, :object_root => false do
        attributes :id, :name, :repetitions
      end
    elsif item.is_a?(Reward)
      attributes :image_url, :reward_image_id
    end
  end
end
