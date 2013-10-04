['Throw and Catch', 'Bounce & Catch', 'Ground Balls To', 'Ground Balls Away',
 'Throw & Cradle', 'Quickstick', 'One hand', 'Throw and Shoot', 'Jump',
 'Hand on your hips!', 'Hand on your knees!', 'Hand up!', 'Jump up high',
 'Turn around', 'Stand up and jump!', 'Stand on your left leg', 'Stand on your right'].each do |name|
  Drill.create do |drill|
    drill.name = name
    drill.description = name
  end
end

