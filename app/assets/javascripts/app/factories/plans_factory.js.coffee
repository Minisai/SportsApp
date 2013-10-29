@app.factory "PlansFactory", ["$resource", ($resource) ->
  $resource("/coaches/plans/:id", {id: "@id"}, {update: {method: 'PUT'}})
]