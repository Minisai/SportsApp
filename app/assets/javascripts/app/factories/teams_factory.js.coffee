@app.factory "TeamsFactory", ["$resource", ($resource) ->
  $resource("/coaches/teams/:id", {id: "@id"}, {update: {method: 'PUT'}})
]