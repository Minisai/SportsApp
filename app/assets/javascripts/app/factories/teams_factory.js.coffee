@app.factory "TeamsFactory", ["$resource", ($resource) ->
  $resource("teams//:id", {id: "@id"}, {update: {method: 'PUT'}})
]