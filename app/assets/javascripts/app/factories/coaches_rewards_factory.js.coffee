@app.factory "CoachesRewardsFactory", ["$resource", ($resource) ->
  $resource("/coaches/rewards/:id", {id: "@id"}, {update: {method: 'PUT'}})
]