object @assessment
attributes :id, :name, :description
child :exercises, :object_root => false do
  attributes :id, :name, :repetitions, :drill_id
end