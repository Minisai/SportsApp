@app.factory "RewardImagesFactory", ["$resource", ($resource) ->
  $resource("/coaches/reward_images/:id", {id: "@id"}, {update: {method: 'PUT'}})
]