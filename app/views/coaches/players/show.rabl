object @player
attributes :id, :name
child :user, :object_root => false do
  attributes :last_sign_in_at
end
