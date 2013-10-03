['Throw and Catch', 'Bounce & Catch', 'Ground Balls To', 'Ground Balls Away',
 'Throw & Cradle', 'Quickstick', 'One hand', 'Throw and Shoot'].each do |name|
  Drill.create do |drill|
    drill.name = name
    drill.description = name
  end
end