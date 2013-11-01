@app.factory "PlansTeamsFactory", ["$resource", ($resource) ->
  $resource("/coaches/plans/:plan_id/teams/:id", {plan_id: "@plan_id", id: "@id"}, {update: {method: 'PUT'}})
]