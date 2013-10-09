@app.factory "RewardsFactory", ["$resource", ($resource) ->
  $resource("/rewards/:id", {id: "@id"}, {update: {method: 'PUT'}})
]