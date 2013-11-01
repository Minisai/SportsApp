@app.factory "PlansPlayersFactory", ["$resource", ($resource) ->
  $resource("/coaches/plans/:plan_id/players/:id", {plan_id: "@plan_id", id: "@id"}, {update: {method: 'PUT'}})
]